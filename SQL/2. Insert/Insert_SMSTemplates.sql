INSERT INTO `SMSTemplates` (`templateName`,`message`,`languageID`)
SELECT * FROM (SELECT 'OTP','Dear user, you verification code is <OTP>.','English' ) AS tmp
WHERE NOT EXISTS (
    SELECT * FROM `SMSTemplates` WHERE `templateName` = 'OTP' AND `languageID` = 'English'
) LIMIT 1;