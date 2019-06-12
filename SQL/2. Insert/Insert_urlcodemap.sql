
INSERT INTO urlcodemap (encoded,decoded)
  SELECT * FROM (SELECT '+',' ') AS tmp
WHERE NOT EXISTS (
    SELECT encoded,decoded FROM urlcodemap WHERE encoded = '+' AND decoded = ' '
) LIMIT 1;

INSERT INTO urlcodemap (encoded,decoded)
  SELECT * FROM (SELECT '%2C',',') AS tmp
WHERE NOT EXISTS (
    SELECT encoded,decoded FROM urlcodemap WHERE encoded = '+' AND decoded = ' '
) LIMIT 1;
