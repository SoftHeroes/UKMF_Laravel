DROP FUNCTION IF EXISTS getLanguageID;
  
CREATE FUNCTION getLanguageID(val varchar(1024))
  RETURNS INT(10)
  DETERMINISTIC
BEGIN
  DECLARE LangCode INT(10);

SET LangCode = (SELECT u_ID FROM languageLookup WHERE `language` = val);
 return LangCode;
END

  -- SELECT getLanguageID('English')