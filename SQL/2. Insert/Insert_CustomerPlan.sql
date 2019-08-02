INSERT INTO CustomerPlan (PlanName,InvaildUpdateAttemptsAllowed ,userLockTime,QRCodeMethods,walletAmountLimit)
SELECT * FROM (SELECT 'Free Account',3,600,null,100000) AS tmp
WHERE NOT EXISTS (
    SELECT PlanName FROM CustomerPlan WHERE PlanName = 'Free Account'
) LIMIT 1;