DROP FUNCTION IF EXISTS getSMSTemplate;

DELIMITER $$

CREATE FUNCTION getSMSTemplate (
    p_TemplateName VARCHAR(255),
    p_Language VARCHAR(255),
    p_OTP  INT,
    p_PhoneNumber VARCHAR(10)
    )
    RETURNS VARCHAR(5000) DETERMINISTIC
    BEGIN
		DECLARE SMSMessage VARCHAR(5000) DEFAULT null;
		DECLARE CustomerPlanID INT(10) DEFAULT null;
		DECLARE CustomerFirstName VARCHAR(100) DEFAULT null;
		DECLARE InvaildUpdateAttempts INT(11);
		DECLARE LockTime INT(10);

		SELECT `message` INTO SMSMessage FROM `SMSTemplates` WHERE `templateName` = p_TemplateName AND `languageID` = p_Language AND `Active` = 1 AND `Deleted` = 0 ;
		SELECT `firstName`,`PlanID` INTO CustomerFirstName,CustomerPlanID FROM `Customer` WHERE phoneNumber = p_PhoneNumber;
		SELECT `InvaildUpdateAttemptsAllowed`,`userLockTime` INTO InvaildUpdateAttempts,LockTime FROM `CustomerPlan` WHERE u_ID = CustomerPlanID;


		SET SMSMessage = replace(SMSMessage,'<OTP>', CASE WHEN p_OTP IS NULL THEN '' ELSE p_OTP END );
		SET SMSMessage = replace(SMSMessage,'<Company Name>', 'UK MICRO FINANCE');
		SET SMSMessage = replace(SMSMessage,'<Customer Name>', CASE WHEN CustomerFirstName IS NULL THEN '' ELSE CustomerFirstName END);
		SET SMSMessage = replace(SMSMessage,'<LockTime>', CASE WHEN LockTime IS NULL THEN '' ELSE LockTime*100/60 END);
		SET SMSMessage = replace(SMSMessage,'<INVALID ATTEMPT>', CASE WHEN InvaildUpdateAttempts  IS NULL THEN '' ELSE InvaildUpdateAttempts END);


		return URLENCODER(SMSMessage);
	END$$

DELIMITER ;

  -- SELECT getSMSTemplate('AccountLock','English',6565,'9630054749')