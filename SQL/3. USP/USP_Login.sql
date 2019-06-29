DROP procedure IF EXISTS `USP_login`;
DELIMITER $$
CREATE PROCEDURE `USP_login` ( IN p_Username VARCHAR(255),IN p_Password VARCHAR(255) ,IN p_Source VARCHAR(255),IN p_Language VARCHAR(255))
proc_Call:BEGIN
  DECLARE RowCount INT DEFAULT 0;
  DECLARE CustomerPhoneNumber VARCHAR(10);
  DECLARE ErrorNumber INT;
  DECLARE ErrorMessage VARCHAR(1000);
  DECLARE CustomerUUID VARCHAR(100);
  DECLARE CustomerEmail VARCHAR(225);
DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,CustomerUUID,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00000' AND `language` = p_Language;
      ROLLBACK;
    END;

  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,CustomerUUID,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00012' AND `language` = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languageLookup where language = p_Language) THEN
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,CustomerUUID,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00009' AND `language` = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
  
  -- Input check block : START
  IF(  p_Username IS NULL OR TRIM(p_Username) = '' ) THEN
    BEGIN
    SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,CustomerUUID,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00010' AND `language` = p_Language;
    LEAVE proc_Call;
    END;
  ELSEIF ( p_Password IS NULL OR TRIM(p_Password) = '' ) THEN
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,CustomerUUID,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00011' AND `language` = p_Language;
      LEAVE proc_Call;
    END;
  ELSEIF ( p_Source IS NULL OR TRIM(p_Source) = '' ) THEN
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,CustomerUUID,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00022' AND `language` = p_Language;
      LEAVE proc_Call;
    END;

  END IF;
	-- Input check block : END
    
    
  -- Credentials validation block : START
  SELECT phoneNumber,emailID,UUID INTO CustomerPhoneNumber,CustomerEmail,CustomerUUID FROM `Customer` WHERE emailID = p_Username OR phoneNumber = p_Username OR CustomerEmail = p_Username OR CustomerPhoneNumber = p_Username;

  IF( CustomerPhoneNumber IS NULL OR TRIM(CustomerPhoneNumber) = '' ) THEN
    BEGIN
       SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00008' AND `language` = p_Language;
      LEAVE proc_Call;
    END;
  END IF;

  SET RowCount = ( SELECT 1 FROM `Customer` WHERE phoneNumber = CustomerPhoneNumber AND password = AES_ENCRYPT(p_Password,CustomerPhoneNumber) );

  IF(RowCount > 0 ) THEN 
    SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage,CustomerUUID,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00006' AND `language` = p_Language;
  ELSE
    SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,CustomerUUID,`CustomerEmail`,`CustomerPhoneNumber`, ErrorMessage,CustomerUUID,CustomerEmail,CustomerPhoneNumber FROM `MessageMaster` WHERE `Code` = 'ERR00008' AND `language` = p_Language;
  END IF;
  -- Credentials validation block : END
END$$

DELIMITER ;

/*
call USP_login('9630054749','Test123!','xd','English');
  */