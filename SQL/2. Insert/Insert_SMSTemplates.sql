-- TRUNCATE TABLE `SMSTemplates`;

INSERT INTO `SMSTemplates` (`templateName`,`message`,`languageID`)
SELECT * FROM (SELECT 'OTP','Dear User,%0D%0A%0D%0AYou verification code is <OTP>.','English' ) AS tmp
WHERE NOT EXISTS (
    SELECT * FROM `SMSTemplates` WHERE `templateName` = 'OTP' AND `languageID` = 'English'
) LIMIT 1;

INSERT INTO `SMSTemplates` (`templateName`,`message`,`languageID`)
SELECT * FROM (SELECT 'welcomeMessage','<Customer Name>,%0D%0A%0D%0AThanks For Joining <Company Name>.','English' ) AS tmp
WHERE NOT EXISTS (
    SELECT * FROM `SMSTemplates` WHERE `templateName` = 'welcomeMessage' AND `languageID` = 'English'
) LIMIT 1;

INSERT INTO `SMSTemplates` (`templateName`,`message`,`languageID`)
SELECT * FROM (SELECT 'resetPassword','<Customer Name>,%0D%0A%0D%0Ayour Reset Password Code is This <OTP>.','English' ) AS tmp
WHERE NOT EXISTS (
    SELECT * FROM `SMSTemplates` WHERE `templateName` = 'resetPassword' AND `languageID` = 'English'
) LIMIT 1;


INSERT INTO `SMSTemplates` (`templateName`,`message`,`languageID`)
SELECT * FROM (SELECT 'AccountLock','Dear <Customer Name>,%0D%0A%0D%0AYour  Account lock for <LockTime> Min .Due to <INVALID ATTEMPT> INVALID ATTEMPT.','English' ) AS tmp
WHERE NOT EXISTS (
    SELECT * FROM `SMSTemplates` WHERE `templateName` = 'AccountLock' AND `languageID` = 'English'
) LIMIT 1;

