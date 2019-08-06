DROP procedure IF EXISTS USP_userLogin;
DELIMITER $$
CREATE PROCEDURE USP_userLogin ( IN p_Username VARCHAR(255),IN p_Password VARCHAR(255) ,IN p_Source VARCHAR(255),IN p_Language VARCHAR(255))
proc_Call:BEGIN
  DECLARE RowCount INT DEFAULT 0;
  DECLARE UserPhoneNumber VARCHAR(10);
  DECLARE ErrorNumber INT;
  DECLARE ErrorMessage VARCHAR(1000);
  DECLARE UserEmail VARCHAR(225);
  DECLARE op_Username VARCHAR(225);
  DECLARE UserUUID VARCHAR(225);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00000' AND language = p_Language;
      ROLLBACK;
    END;

  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00012' AND language = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languageLookup where language = p_Language) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00009' AND language = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
  
  -- Input check block : START
  IF(  p_Username IS NULL OR TRIM(p_Username) = '' ) THEN
    BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00010' AND language = p_Language;
    LEAVE proc_Call;
    END;
  ELSEIF ( p_Source IS NULL OR TRIM(p_Source) = '' ) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00022' AND language = p_Language;
      LEAVE proc_Call;
    END;
  ELSEIF ( p_Password IS NULL OR TRIM(p_Password) = '' ) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00011' AND language = p_Language;
      LEAVE proc_Call;
    END;
  ELSEIF NOT EXISTS(  SELECT 1 FROM lookUp WHERE name = p_Source AND category = 'source' AND languageID =  getLanguageID(p_Language)  ) THEN
    BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username  FROM MessageMaster  WHERE Code = 'ERR00033' AND language = p_Language;
          LEAVE proc_Call;
    END;
  END IF;
	-- Input check block : END
    
    
  -- Credentials validation block : START
  SELECT phoneNumber,emailID,username,UUID INTO UserPhoneNumber,UserEmail,op_Username,UserUUID FROM userInformation WHERE  ( emailID = p_Username OR phoneNumber = p_Username OR username = p_Username  ) AND isLock = 0;

  IF( UserPhoneNumber IS NULL OR TRIM(UserPhoneNumber) = '' ) THEN
    BEGIN
       SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00008' AND language = p_Language;
      LEAVE proc_Call;
    END;
  END IF;


  SET RowCount = ( SELECT 1 FROM userInformation WHERE phoneNumber = UserPhoneNumber AND password = AES_ENCRYPT(p_Password,UserPhoneNumber) );
  

  IF(RowCount > 0 ) THEN 
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00006' AND language = p_Language;
  ELSE
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage,UserEmail,UserPhoneNumber,UserUUID,op_Username as Username FROM MessageMaster WHERE Code = 'ERR00008' AND language = p_Language;
  END IF;
  -- Credentials validation block : END
END$$

DELIMITER ;

/*
call USP_userLogin('superUser','Test123!','Android','English');
  */