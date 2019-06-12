DROP FUNCTION IF EXISTS getSMSTemplate;

CREATE FUNCTION getSMSTemplate (p_TemplateName VARCHAR(255),p_PhoneNumber VARCHAR(10),p_Language VARCHAR(255) )
   RETURNS VARCHAR(5000)
   DETERMINISTIC
  BEGIN
    DECLARE SMSMessage VARCHAR(5000) DEFAULT null;

    SELECT `message` INTO SMSMessage FROM `smsTemplates` WHERE `templateName` = p_TemplateName AND `languageID` = p_Language AND `Active` = 1 AND `Deleted` = 0 ;

    SET SMSMessage = replace(SMSMessage,'<OTP>', FLOOR( 1000 + ( RAND( ) *8999 ) ));
    
    return URLENCODER(SMSMessage);
  END

  -- SELECT getSMSTemplate('OTP','5','English')