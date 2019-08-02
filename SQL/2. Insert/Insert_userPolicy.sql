INSERT INTO userPolicy (policyName)
  SELECT * FROM (SELECT 'superUser') AS tmp
WHERE NOT EXISTS (
    SELECT policyName FROM userPolicy WHERE policyName = 'superUser'
) LIMIT 1;
