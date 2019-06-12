DELIMITER $$

DROP FUNCTION IF EXISTS `URLEncoder`$$

CREATE FUNCTION `URLEncoder`(str VARCHAR(4096) ) RETURNS VARCHAR(4096) DETERMINISTIC
BEGIN
  DECLARE X  INT;               
  DECLARE EncodeValue VARCHAR(256);
  DECLARE DecodeValue VARCHAR(256);
  SET X = 1;
  WHILE X  <= (SELECT MAX(id) FROM urlcodemap) DO
     SET EncodeValue = (SELECT `encoded` FROM urlcodemap WHERE id = X);
     SET DecodeValue = (SELECT `decoded` FROM urlcodemap WHERE id = X);                
     SET str = replace(str,DecodeValue,EncodeValue);
     SET  X = X + 1;                           
  END WHILE;
  RETURN str;
END$$

DELIMITER ;