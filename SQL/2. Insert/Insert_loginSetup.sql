INSERT INTO loginSetup (source, OTPExpiryTime, resendOTPAttempts, OTPAttempts, userLockTiming)
  SELECT * FROM (SELECT 'Android',60,5,3,600) AS tmp
WHERE NOT EXISTS (
    SELECT source, OTPExpiryTime, resendOTPAttempts, OTPAttempts, userLockTiming FROM loginSetup
     WHERE source =  'Android' AND OTPExpiryTime =  60 AND resendOTPAttempts =  5 AND OTPAttempts =  3 AND userLockTiming =  600 
) LIMIT 1;