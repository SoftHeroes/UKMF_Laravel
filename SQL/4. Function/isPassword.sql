DELIMITER $$

DROP FUNCTION IF EXISTS isPassword$$

CREATE FUNCTION isPassword(p_Password varchar(255))   RETURNS TINYINT(4) DETERMINISTIC
BEGIN

     IF(LENGTH(p_Password) < 8) THEN
      RETURN 1;  -- ERR00032 : Password length should be greater than eight.
     END IF;
   
     IF(p_Password NOT RLIKE BINARY '^(?=.*[a-z]).*$') THEN
        RETURN 2;  -- ERR00036 : Password must contain at least 1 lowercase letter.
     END IF;

     IF(p_Password NOT RLIKE BINARY '^(?=.*[A-Z]).*$') THEN
        RETURN 3;  -- ERR00037 : Password must contain at least 1 uppercase letter.
     END IF;

     IF(p_Password NOT RLIKE BINARY '^(?=.*[0-9]).*$') THEN
        RETURN 4;  -- ERR00038 : Password must contain at least 1 digit.
     END IF;

     IF(p_Password NOT RLIKE BINARY '^(?=.*[@|%|!|#|$|:|(|)|{|}|~|_]).*$') THEN
        RETURN 5;  -- ERR00039 : Password must contain at least 1 special character form ( @,%,!,#,$,:,(,),{,},~,_ ).
     END IF;

    RETURN 0;
END$$

DELIMITER ;
-- SELECT isPassword('Test123!')