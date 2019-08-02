DROP FUNCTION IF EXISTS getLanguageID;

DELIMITER $$

CREATE FUNCTION getLanguageID(val varchar(1024))
  RETURNS INT(10)
  DETERMINISTIC
BEGIN
  DECLARE LangCode INT(10);

SET LangCode = (SELECT uniqueID FROM languageLookup WHERE `language` = val);
 return LangCode;
END$$

DELIMITER ;
  -- SELECT getLanguageID('English')