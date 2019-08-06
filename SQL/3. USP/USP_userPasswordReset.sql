DROP procedure IF EXISTS USP_userPasswordReset;
DELIMITER $$
CREATE PROCEDURE USP_userPasswordReset ( IN p_PhoneNumber VARCHAR(255),IN p_OTP VARCHAR(255),IN p_NewPassword VARCHAR(255) ,IN p_ConfirmPassword VARCHAR(255),IN p_Source VARCHAR(255),IN p_Language VARCHAR(255))
proc_Call:BEGIN
  DECLARE RowCount INT DEFAULT 0;
  DECLARE ErrorNumber INT;
  DECLARE ErrorMessage VARCHAR(1000);
  DECLARE OTPExpiryTime DATETIME;
  DECLARE OTPSendTime DATETIME;
  DECLARE OTPTimeForValidationInSeconds INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00000' AND language = p_Language;
      ROLLBACK;
    END;

  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00012' AND language = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languageLookup where language = p_Language) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00009' AND language = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
  
  -- Input check block : START
  IF(  p_PhoneNumber IS NULL OR TRIM(p_PhoneNumber) = '' ) THEN
    BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00019' AND language = p_Language;
    LEAVE proc_Call;
    END;
  ELSEIF ( p_Source IS NULL OR TRIM(p_Source) = '' ) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00022' AND language = p_Language;
      LEAVE proc_Call;
    END;
  ELSEIF ( p_NewPassword IS NULL OR TRIM(p_NewPassword) = '' ) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00011' AND language = p_Language;
      LEAVE proc_Call;
    END;
  ELSEIF ( p_ConfirmPassword IS NULL OR TRIM(p_ConfirmPassword) = '' ) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00017' AND language = p_Language;
      LEAVE proc_Call;
    END;
  ELSEIF ( STRCMP( p_NewPassword,p_ConfirmPassword ) ) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00013' AND language = p_Language;
      LEAVE proc_Call;
    END;
  ELSEIF( isPassword(p_NewPassword) != 0 ) THEN
    BEGIN
        
        DECLARE  passwordReason tinyint(4);
        SET passwordReason = isPassword(p_NewPassword);

        IF(passwordReason = 1) THEN  -- 1 : ERR00032 : Password length should be greater than eight.
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00032' AND language = p_Language;
        END IF;

        IF(passwordReason = 2) THEN -- 2 : ERR00036 : Password must contain at least 1 lowercase letter.
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00036' AND language = p_Language;
        END IF;

        IF(passwordReason = 3) THEN -- 3 : ERR00037 : Password must contain at least 1 uppercase letter.
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00037' AND language = p_Language;
        END IF;

        IF(passwordReason = 4) THEN -- 4 : ERR00038 : Password must contain at least 1 digit.
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00038' AND language = p_Language;
        END IF;

        IF(passwordReason = 5) THEN -- 5 : ERR00039 : Password must contain at least 1 special character form ( @,%,!,#,$,:,(,),{,},~,_ ).
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00039' AND language = p_Language;
        END IF;
                        
        LEAVE proc_Call;
    END;
  ELSEIF NOT EXISTS(  SELECT 1 FROM lookUp WHERE name = p_Source AND category = 'source' AND languageID =  getLanguageID(p_Language)  ) THEN
    BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage  FROM MessageMaster  WHERE Code = 'ERR00033' AND language = p_Language;
          LEAVE proc_Call;
    END;
  END IF;
	-- Input check block : END
    
  
  -- User verification block : START  
    IF NOT EXISTS(  SELECT 1 FROM userInformation WHERE phoneNumber = p_PhoneNumber AND deletedAt IS NULL ) THEN
      BEGIN
            SELECT Code,ErrorFound,Message,version,language,ErrorMessage  FROM MessageMaster  WHERE Code = 'ERR00042' AND language = p_Language;
            LEAVE proc_Call;
      END;
    END IF;
  -- User verification block : END

  -- OTP verification block : START  
    IF NOT EXISTS(  SELECT 1 FROM userOTPLog WHERE userPhoneNumber = p_PhoneNumber AND OTP = p_OTP  ) THEN
      BEGIN
            SELECT Code,ErrorFound,Message,version,language,ErrorMessage  FROM MessageMaster  WHERE Code = 'ERR00041' AND language = p_Language;
            LEAVE proc_Call;
      END;
    END IF;

    SET OTPTimeForValidationInSeconds = ( SELECT otpValidTime FROM userPolicy WHERE uniqueID = ( SELECT UserPolicyID FROM userInformation  WHERE phoneNumber = p_PhoneNumber LIMIT 1 ) );
    SET OTPSendTime = ( SELECT sendTime FROM userOTPLog WHERE userPhoneNumber = p_PhoneNumber AND OTP = p_OTP);

    SET OTPExpiryTime = DATE_ADD( OTPSendTime, INTERVAL OTPTimeForValidationInSeconds SECOND );

    IF ( CURRENT_TIMESTAMP()  >  OTPExpiryTime ) THEN
      BEGIN
            SELECT Code,ErrorFound,Message,version,language,ErrorMessage  FROM MessageMaster  WHERE Code = 'ERR00046' AND language = p_Language;
            LEAVE proc_Call;
      END;
    END IF;

  -- OTP verification block : END

  -- Password Update block : START

    START TRANSACTION;
  
    UPDATE userInformation 
        SET password = AES_ENCRYPT(p_NewPassword,p_PhoneNumber) , isLock = 0, InvaildUpdateAttemptsCount = 0 , lastUpdateDatetime = CURRENT_TIMESTAMP() 
        WHERE phoneNumber = p_PhoneNumber AND deletedAt IS NULL ;

    COMMIT WORK;
    
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage  FROM MessageMaster  WHERE Code = 'ERR00043' AND language = p_Language;
  -- Password Update block : END

END$$

DELIMITER ;

/*
call USP_userPasswordReset('9074200979','695609','Test123!','Test123!','Android','English');
  */