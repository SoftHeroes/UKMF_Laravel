INSERT INTO `customerplan` (`PlanName`,`InvaildUpdateAttemptsAllowed` ,`userLockTime`,`QRCodeMethods`,`walletAmountLimit`)
SELECT * FROM (SELECT 'Free Account',3,600,null,100000) AS tmp
WHERE NOT EXISTS (
    SELECT `PlanName` FROM `customerplan` WHERE `PlanName` = 'Free Account'
) LIMIT 1;