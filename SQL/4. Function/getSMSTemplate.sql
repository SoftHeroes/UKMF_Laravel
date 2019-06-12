DROP FUNCTION IF EXISTS getSMSTemplate;

CREATE FUNCTION getSMSTemplate (
    p_TemplateName VARCHAR(255),
    p_Language VARCHAR(255),
    p_OTP  INT
   )
   RETURNS VARCHAR(5000)
   DETERMINISTIC
  BEGIN
    DECLARE SMSMessage VARCHAR(5000) DEFAULT null;

    SELECT `message` INTO SMSMessage FROM `smsTemplates` WHERE `templateName` = p_TemplateName AND `languageID` = p_Language AND `Active` = 1 AND `Deleted` = 0 ;

    SET SMSMessage = replace(SMSMessage,'<OTP>', p_OTP );
    
    return URLENCODER(SMSMessage);
  END

  -- SELECT getSMSTemplate('OTP','English',6565)