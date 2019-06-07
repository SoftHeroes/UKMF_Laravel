INSERT INTO `languageLookup` (`language`)
SELECT * FROM (SELECT 'English') AS tmp
WHERE NOT EXISTS (
    SELECT `language` FROM `languageLookup` WHERE `language` = 'English'
) LIMIT 1;