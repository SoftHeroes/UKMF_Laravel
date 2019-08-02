DROP procedure IF EXISTS USP_getSMSURL;

DELIMITER $$
CREATE PROCEDURE USP_getSMSURL ( 
    IN p_Source VARCHAR(255),
--     IN p_APIName VARCHAR(255),
    IN p_TemplateName VARCHAR(255),
    IN p_PhoneNumber VARCHAR(10),
    IN p_Language VARCHAR(255)
  )
proc_Call:BEGIN

  -- Output varibles : START
  DECLARE op_Environment VARCHAR(200);
  DECLARE RowCount INT DEFAULT NULL;
  DECLARE ErrorNumber INT;
  DECLARE op_ErrorMessage VARCHAR(1000);
  DECLARE op_URL VARCHAR(5000) DEFAULT '';
  DECLARE op_Method VARCHAR(255);  DECLARE op_UserID varchar(255);
  DECLARE op_Password varchar(255);
  DECLARE op_AccessCode varchar(255);
  DECLARE op_ResponseStatusTag varchar(255);
  DECLARE op_ResponseMessageTag varchar(255);
  DECLARE op_APIName varchar(255);
  DECLARE op_APIID INT(10);
  DECLARE op_AlreadyRegisteredUser varchar(10) DEFAULT 'NO';
  DECLARE op_CustomerPassword varchar(255) DEFAULT NULL;
  DECLARE op_OTPExpiryTime INT (2);
  DECLARE op_resendOTPAttempts INT (2);
  DECLARE op_OTPAttempts INT (2);
  DECLARE op_userLockTiming INT (2);
  -- Output varibles : END

  -- Helper varibles : START
  DECLARE SMSMessage varchar(1000);
  DECLARE OTP INT;
  -- Helper varibles : END

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,op_ErrorMessage = MESSAGE_TEXT;
      SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00000' AND language = p_Language;
      ROLLBACK;
    END;


  SET op_Environment  = (SELECT envName FROM APP_ENV LIMIT 1); -- Getting op_Environment value
  

  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00012' AND language = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languageLookup where language = p_Language) THEN
    BEGIN
      SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00009' AND language = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
	
  -- Input check block : START
  IF(  p_Source IS NULL OR TRIM(p_Source) = '' ) THEN
      BEGIN
          SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00022' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF NOT EXISTS(  SELECT 1 FROM lookUp WHERE name = p_Source AND category = 'source' AND languageID =  getLanguageID(p_Language)  ) THEN
    BEGIN
          SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00033' AND language = p_Language;
          LEAVE proc_Call;
    END;
  ELSEIF(  p_PhoneNumber IS NULL OR TRIM(p_PhoneNumber) = '' ) THEN
      BEGIN
          SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00019' AND language = p_Language;
          LEAVE proc_Call;
      END;
--   ELSEIF(  p_APIName IS NULL OR TRIM(p_APIName) = '' ) THEN
--       BEGIN
--           SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00026' AND language = p_Language;
--           LEAVE proc_Call;
--       END;
  ELSEIF(  p_TemplateName IS NULL OR TRIM(p_TemplateName) = '' ) THEN
      BEGIN
          SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00023' AND language = p_Language;
          LEAVE proc_Call;
      END;
  END IF;
	-- Input check block : END


  -- Phone Number valdation block : START
  IF(  !isNumeric(p_PhoneNumber) OR LENGTH(p_PhoneNumber) != 10 ) THEN
    BEGIN
        SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00002' AND language = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
  -- Phone Number valdation block : END

  -- API validation : START
--   SET RowCount = ( SELECT 1 FROM SMSAPISetups WHERE APIName = p_APIName AND op_Environment = op_Environment AND Active = 1 AND Deleted = 0 );
--   IF( RowCount IS NULL) THEN
--     BEGIN
--         SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00027' AND language = p_Language;
--         LEAVE proc_Call;
--     END;
--   END IF;
  -- API validation : END

  IF EXISTS (SELECT 1 FROM Customer WHERE phoneNumber = p_PhoneNumber) THEN
    BEGIN
      SET op_AlreadyRegisteredUser = 'YES';
      set op_CustomerPassword =  (SELECT AES_DECRYPT(password,p_PhoneNumber) FROM Customer WHERE phoneNumber = p_PhoneNumber);
    END;
  END IF;



  -- Getting Template and validation : START
  SET RowCount = ( SELECT 1 FROM SMSTemplates WHERE templateName = p_TemplateName AND language = p_Language AND Active = 1 AND Deleted = 0 );
  IF( RowCount IS NULL) THEN
    BEGIN
        SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00025' AND language = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
  -- Getting Template and validation : END

  SELECT OTPExpiryTime,
    resendOTPAttempts,
    OTPAttempts,
    userLockTiming INTO op_OTPExpiryTime,
    op_resendOTPAttempts,
    op_OTPAttempts,
    op_userLockTiming
  FROM loginSetup WHERE source = p_Source;

  -- Message Varibles populating block : STRAT
  SET OTP =FLOOR( 100000 + ( RAND( ) *899999 ) );
  -- Message Varibles populating block : END

  -- op_URL Generation block : START 
  SELECT CONCAT( (CASE WHEN server IS NULL THEN '' ELSE TRIM(server) END ),
               (CASE WHEN resource IS NULL THEN '' ELSE TRIM(resource) END ),
               (CASE WHEN param1 IS NULL THEN '' ELSE CONCAT(TRIM(param1),'=',TRIM(value1),'&') END ),
               (CASE WHEN param2 IS NULL THEN '' ELSE CONCAT(TRIM(param2),'=',TRIM(value2),'&') END ),
               (CASE WHEN param3 IS NULL THEN '' ELSE CONCAT(TRIM(param3),'=',TRIM(value3),'&') END ),
               (CASE WHEN param4 IS NULL THEN '' ELSE CONCAT(TRIM(param4),'=',TRIM(value4),'&') END ),
               (CASE WHEN param5 IS NULL THEN '' ELSE CONCAT(TRIM(param5),'=',TRIM(value5),'&') END ),
               (CASE WHEN param6 IS NULL THEN '' ELSE CONCAT(TRIM(param6),'=',TRIM(value6),'&') END ),
               (CASE WHEN param7 IS NULL THEN '' ELSE CONCAT(TRIM(param7),'=',TRIM(value7),'&') END ),
               (CASE WHEN receiverTag IS NULL THEN '' ELSE CONCAT(TRIM(receiverTag),'=',TRIM(p_PhoneNumber),'&') END ),
               (CASE WHEN messageTag IS NULL THEN '' ELSE CONCAT(TRIM(messageTag),'=',TRIM(getSMSTemplate(p_TemplateName,p_Language,OTP,p_PhoneNumber))) END )
         )  AS op_URL, 
         method,
         userID,
         AES_DECRYPT(password,APIName),
         AES_DECRYPT(accessCode,APIName),
         responseStatusTag,
         responseMessageTag,
         APIName,
         u_ID
  INTO op_URL,op_Method,op_UserID,op_Password,op_AccessCode,op_ResponseStatusTag,op_ResponseMessageTag,op_APIName,op_APIID
  FROM SMSAPISetups WHERE /*APIName = p_APIName AND */ op_Environment = op_Environment AND Active = 1 AND Deleted = 0;
    

  SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_ResponseStatusTag as ResponseStatusTag,op_ResponseMessageTag as ResponseMessageTag,op_APIName as APIName,op_APIID as APIID,OTP,op_AlreadyRegisteredUser as AlreadyRegisteredUser,op_OTPExpiryTime as OTPExpiryTime,op_resendOTPAttempts as resendOTPAttempts,op_OTPAttempts as OTPAttempts,op_userLockTiming as userLockTiming,op_CustomerPassword as CustomerPassword FROM MessageMaster  WHERE Code = 'ERR00028' AND language = p_Language;
  -- op_URL Generation block : START

END$$

DELIMITER ;

/*
call USP_getSMSURL('Android','OTP','9074200979','English');
*/
