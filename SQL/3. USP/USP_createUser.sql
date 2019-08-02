DROP procedure IF EXISTS USP_createUser;

DELIMITER $$
CREATE PROCEDURE USP_createUser ( 
    IN p_Password VARCHAR(255),
    IN p_ConfirmPassword VARCHAR(255),
    IN p_FirstName VARCHAR(255),
    IN p_MiddleName VARCHAR(255),
    IN p_LastName VARCHAR(255),
    IN p_EmailID VARCHAR(255),
    IN p_PhoneNumber VARCHAR(255),
    IN p_userPolicyID INT,
    IN p_Language VARCHAR(255),
    IN p_Source VARCHAR(255)
  )
proc_Call:BEGIN
	DECLARE RowCount INT DEFAULT 0;
  DECLARE ErrorNumber INT;
  DECLARE ErrorLine INT;
  DECLARE ErrorMessage VARCHAR(1000);
  DECLARE op_UUID VARCHAR(64);
      
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00000' AND language = p_Language;
      ROLLBACK;
    END;


  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00012' AND language = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languageLookup where language = p_Language) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00009' AND language = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
	
  -- Input check block : START
  IF(  p_Password IS NULL OR TRIM(p_Password) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00011' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_ConfirmPassword IS NULL OR TRIM(p_ConfirmPassword) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00017' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_FirstName IS NULL OR TRIM(p_FirstName) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00015' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_LastName IS NULL OR TRIM(p_LastName) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00016' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_EmailID IS NULL OR TRIM(p_EmailID) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00018' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_PhoneNumber IS NULL OR TRIM(p_PhoneNumber) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00019' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_userPolicyID IS NULL OR TRIM(p_userPolicyID) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00005' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF (STRCMP( p_Password,p_ConfirmPassword )) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00013' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF( isPassword(p_Password) != 0 ) THEN
    BEGIN
        
        DECLARE  passwordReason tinyint(4);
        SET passwordReason = isPassword(p_Password);

        IF(passwordReason = 1) THEN  -- 1 : ERR00032 : Password length should be greater than eight.
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00032' AND language = p_Language;
        END IF;

        IF(passwordReason = 2) THEN -- 2 : ERR00036 : Password must contain at least 1 lowercase letter.
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00036' AND language = p_Language;
        END IF;

        IF(passwordReason = 3) THEN -- 3 : ERR00037 : Password must contain at least 1 uppercase letter.
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00037' AND language = p_Language;
        END IF;

        IF(passwordReason = 4) THEN -- 4 : ERR00038 : Password must contain at least 1 digit.
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00038' AND language = p_Language;
        END IF;

        IF(passwordReason = 5) THEN -- 5 : ERR00039 : Password must contain at least 1 special character form ( @,%,!,#,$,:,(,),{,},~,_ ).
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00039' AND language = p_Language;
        END IF;
                        
        LEAVE proc_Call;
    END;
  ELSEIF (p_Source IS NULL OR TRIM(p_Source) = '') THEN
    BEGIN
        SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00022' AND language = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
	-- Input check block : END

	-- Email format valdation block : START
  IF( !isEmail(p_EmailID) ) THEN 
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00001' AND language = p_Language;
      LEAVE proc_Call;
    END;
  -- Email format valdation block : END

  -- Phone Number valdation block : START
  ELSEIF(  !isNumeric(p_PhoneNumber) OR LENGTH(p_PhoneNumber) != 10 ) THEN
    BEGIN
        SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00002' AND language = p_Language;
        LEAVE proc_Call;
    END;
  -- Phone Number valdation block : END
  END IF;
	
  -- User Policy ID valdation block : START
  SET RowCount = ( SELECT 1 FROM userPolicy WHERE u_ID = p_userPolicyID);
  IF(  RowCount = 0 OR RowCount IS NULL ) THEN
    BEGIN
        SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00034' AND language = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
  -- User Policy ID valdation block : END

	-- Duplicate validation block : START
	SET RowCount = ( SELECT 1 FROM userInformation WHERE emailID = p_EmailID);
    
  IF(RowCount > 0 ) THEN 
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00004' AND language = p_Language;
      LEAVE proc_Call;
    END;
  END IF;

	SET RowCount = ( SELECT 1 FROM userInformation WHERE phoneNumber = p_PhoneNumber);
    
  IF(RowCount > 0 ) THEN 
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00003' AND language = p_Language;
      LEAVE proc_Call;
    END;
  END IF;
	-- Duplicate validation block : END

  -- Customer Account creation block : START

  START TRANSACTION;
  SET op_UUID = UUID();
    INSERT INTO userInformation(
      password,
      firstName,
      middleName,
      lastName, 
      emailID, 
      phoneNumber,
      lastUpdateDatetime,
      userPolicyID
    ) 
    VALUES (
      AES_ENCRYPT(p_Password,CAST(p_PhoneNumber as CHAR(10)) ),
      p_FirstName,
      p_MiddleName,
      p_LastName,
      p_EmailID,
      p_PhoneNumber,
      CURRENT_TIMESTAMP(),
      p_userPolicyID
    );
  COMMIT WORK;
  -- Customer Account creation block : END

  SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00035' AND language = p_Language;

END$$

DELIMITER ;

/*
call USP_createUser('Test123!','Test123!','vfv',null,'vfv','1452cd@v.cw','9074200579',1,'English','Android');
*/
