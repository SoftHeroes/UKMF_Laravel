INSERT INTO lookUp (code,name,languageID,category)
  SELECT * FROM (SELECT 1 AS code,'Android',1 AS languageID,'source') AS tmp
WHERE NOT EXISTS (
    SELECT category,code,name,languageID FROM lookUp WHERE code = 1 AND name = 'Android' AND languageID = 1 AND category = 'source'
) LIMIT 1;

INSERT INTO lookUp (code,name,languageID,category)
  SELECT * FROM (SELECT 1 AS code,'Web',1 AS languageID,'source') AS tmp
WHERE NOT EXISTS (
    SELECT category,code,name,languageID FROM lookUp WHERE code = 1 AND name = 'Web' AND languageID = 1 AND category = 'source'
) LIMIT 1;