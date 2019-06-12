DROP procedure IF EXISTS `USP_getSMSURL`;

DELIMITER $$
CREATE PROCEDURE `USP_getSMSURL` ( 
    IN p_Source VARCHAR(255),
--     IN p_APIName VARCHAR(255),
    IN p_TemplateName VARCHAR(255),
    IN p_PhoneNumber VARCHAR(10),
    IN p_Language VARCHAR(255)
  )
proc_Call:BEGIN

  DECLARE Environment VARCHAR(200);
	DECLARE RowCount INT DEFAULT NULL;
  DECLARE ErrorNumber INT;
  DECLARE ErrorMessage VARCHAR(1000);
  DECLARE URL VARCHAR(5000) DEFAULT '';
  DECLARE Method VARCHAR(500);
	DECLARE UserID varchar(200);
  DECLARE Password varchar(200);
  DECLARE AccessCode varchar(200);
  DECLARE SMSMessage varchar(1000);
  
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00000' AND `language` = p_Language;
      ROLLBACK;
    END;


  SET Environment  = (SELECT envName FROM app_env LIMIT 1); -- Getting Environment value
  

  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00012' AND `language` = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languagelookup where language = p_Language) THEN
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00009' AND `language` = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
	
  -- Input check block : START
  IF(  p_Source IS NULL OR TRIM(p_Source) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00011' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_PhoneNumber IS NULL OR TRIM(p_PhoneNumber) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00019' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
--   ELSEIF(  p_APIName IS NULL OR TRIM(p_APIName) = '' ) THEN
--       BEGIN
--           SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00026' AND `language` = p_Language;
--           LEAVE proc_Call;
--       END;
  ELSEIF(  p_TemplateName IS NULL OR TRIM(p_TemplateName) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00023' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  END IF;
	-- Input check block : END


  -- Phone Number valdation block : START
  IF(  !isNumeric(p_PhoneNumber) OR LENGTH(p_PhoneNumber) != 10 ) THEN
    BEGIN
        SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00002' AND `language` = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
  -- Phone Number valdation block : END

  -- API validation : START
--   SET RowCount = ( SELECT 1 FROM `SMSAPISetups` WHERE `APIName` = p_APIName AND `environment` = Environment AND `Active` = 1 AND `Deleted` = 0 );
--   IF( RowCount IS NULL) THEN
--     BEGIN
--         SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00027' AND `language` = p_Language;
--         LEAVE proc_Call;
--     END;
--   END IF;
  -- API validation : END

  -- Getting Template and validation : START
  SET RowCount = ( SELECT 1 FROM `smsTemplates` WHERE `templateName` = p_TemplateName AND `languageID` = p_Language AND `Active` = 1 AND `Deleted` = 0 );
  IF( RowCount IS NULL) THEN
    BEGIN
        SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,SMSMessage FROM `messagemaster` WHERE `Code` = 'ERR00025' AND `language` = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
  -- Getting Template and validation : END


  -- URL Generation block : START 
  SELECT CONCAT( (CASE WHEN `server` IS NULL THEN '' ELSE TRIM(`server`) END ),
               (CASE WHEN `resource` IS NULL THEN '' ELSE TRIM(`resource`) END ),
               (CASE WHEN `param1` IS NULL THEN '' ELSE CONCAT(TRIM(`param1`),'=',TRIM(`value1`),'&') END ),
               (CASE WHEN `param2` IS NULL THEN '' ELSE CONCAT(TRIM(`param2`),'=',TRIM(`value2`),'&') END ),
               (CASE WHEN `param3` IS NULL THEN '' ELSE CONCAT(TRIM(`param3`),'=',TRIM(`value3`),'&') END ),
               (CASE WHEN `param4` IS NULL THEN '' ELSE CONCAT(TRIM(`param4`),'=',TRIM(`value4`),'&') END ),
               (CASE WHEN `param5` IS NULL THEN '' ELSE CONCAT(TRIM(`param5`),'=',TRIM(`value5`),'&') END ),
               (CASE WHEN `param6` IS NULL THEN '' ELSE CONCAT(TRIM(`param6`),'=',TRIM(`value6`),'&') END ),
               (CASE WHEN `param7` IS NULL THEN '' ELSE CONCAT(TRIM(`param7`),'=',TRIM(`value7`),'&') END ),
               (CASE WHEN `receiverTag` IS NULL THEN '' ELSE CONCAT(TRIM(`receiverTag`),'=',TRIM(p_PhoneNumber),'&') END ),
               (CASE WHEN `messageTag` IS NULL THEN '' ELSE CONCAT(TRIM(`messageTag`),'=',TRIM(getSMSTemplate(p_TemplateName,p_PhoneNumber,p_Language))) END )
         )  AS URL, 
         `method`,
         `userID`,
         `Password`,
         `accessCode`
  INTO URL,Method,UserID,Password,AccessCode
  FROM `SMSAPISetups` WHERE /*`APIName` = p_APIName AND */ `environment` = Environment AND `Active` = 1 AND `Deleted` = 0;
    

  SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,URL,Method,UserID,Password,AccessCode FROM `messagemaster` WHERE `Code` = 'ERR00028' AND `language` = p_Language;
  -- URL Generation block : START

END$$

DELIMITER ;

/*
call USP_getSMSURL('Any','OTP','9074200979','English');
*/