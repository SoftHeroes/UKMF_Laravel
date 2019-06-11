INSERT INTO `APP_ENV` (`envName`)
SELECT * FROM (SELECT 'local') AS tmp
WHERE NOT EXISTS (
    SELECT `envName` FROM `APP_ENV` WHERE `envName` = 'local'
) LIMIT 1;
