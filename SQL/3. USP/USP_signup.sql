DROP procedure IF EXISTS `USP_signup`;

DELIMITER $$
CREATE PROCEDURE `USP_signup` ( 
    IN p_Password VARCHAR(255),
    IN p_ConfirmPassword VARCHAR(255),
    IN p_FirstName VARCHAR(255),
    IN p_MiddleName VARCHAR(255),
    IN p_LastName VARCHAR(255),
    IN p_EmailID VARCHAR(255),
    IN p_PhoneNumber VARCHAR(255),
    IN p_PlanID VARCHAR(255),
    IN p_Language VARCHAR(255)
  )
proc_Call:BEGIN
	DECLARE RowCount INT DEFAULT 0;
    
  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT `Code`,`ErrorFound`,`Message`,`version`,`language` FROM `messagemaster` WHERE `Code` = 'ERR00012' AND `language` = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languagelookup where language = p_Language) THEN
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language` FROM `messagemaster` WHERE `Code` = 'ERR00009' AND `language` = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
	
  -- Input check block : START
  IF(  p_Password IS NULL OR TRIM(p_Password) = '' ) THEN
      BEGIN
          SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00011' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_ConfirmPassword IS NULL OR TRIM(p_ConfirmPassword) = '' ) THEN
      BEGIN
          SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00017' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_FirstName IS NULL OR TRIM(p_FirstName) = '' ) THEN
      BEGIN
          SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00015' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_LastName IS NULL OR TRIM(p_LastName) = '' ) THEN
      BEGIN
          SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00016' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_EmailID IS NULL OR TRIM(p_EmailID) = '' ) THEN
      BEGIN
          SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00018' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_PhoneNumber IS NULL OR TRIM(p_PhoneNumber) = '' ) THEN
      BEGIN
          SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00019' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_PlanID IS NULL OR TRIM(p_PlanID) = '' ) THEN
      BEGIN
          SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00020' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF (STRCMP( p_Password,p_ConfirmPassword )) THEN
      BEGIN
          SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00013' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  END IF;
	-- Input check block : END

	-- Email format valdation block : START
  IF( p_EmailID NOT RLIKE '^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a??-zA-Z]{2,4}$' ) THEN 
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language` FROM `messagemaster` WHERE `Code` = 'ERR00001' AND `language` = p_Language;
      LEAVE proc_Call;
    END;
  -- Email format valdation block : END

  -- Phone Number valdation block : START
  ELSEIF(  p_PhoneNumber NOT LIKE '^[0-9]+$' OR LENGTH(p_PhoneNumber) != 10 ) THEN
    BEGIN
        SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00002' AND `language` = p_Language;
        LEAVE proc_Call;
    END;
  -- Phone Number valdation block : END
  END IF;
	
  -- Plan ID valdation block : START
  SET RowCount = ( SELECT 1 FROM `customerplan` WHERE u_ID = p_PlanID);
  IF(  RowCount = 0 ) THEN
    BEGIN
        SELECT * FROM `messagemaster` WHERE `Code` = 'ERR00021' AND `language` = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
  -- Plan ID valdation block : END

	-- Duplicate validation block : START
	SET RowCount = ( SELECT 1 FROM `customer` WHERE emailID = p_EmailID);
    
  IF(RowCount > 0 ) THEN 
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language` FROM `messagemaster` WHERE `Code` = 'ERR00004' AND `language` = p_Language;
      LEAVE proc_Call;
    END;
  END IF;

	SET RowCount = ( SELECT 1 FROM `customer` WHERE phoneNumber = p_Password);
    
  IF(RowCount > 0 ) THEN 
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language` FROM `messagemaster` WHERE `Code` = 'ERR00003' AND `language` = p_Language;
      LEAVE proc_Call;
    END;
  END IF;
	-- Duplicate validation block : END

  -- Customer Account creation block : START
  INSERT INTO `Customer`(
    `password`,
    `firstName`,
    `middleName`,
    `lastName`, 
    `emailID`, 
    `phoneNumber`,
    `creationDatetime`,
    `PlanID`
  ) 
  VALUES (
    PASSWORD(p_Password),
    p_FirstName,
    p_MiddleName,
    p_LastName,
    p_EmailID,
    p_PhoneNumber,
    CURRENT_TIMESTAMP(),
    p_PlanID
  );
  -- Customer Account creation block : END


END$$

DELIMITER ;

-- call USP_signup('9074200979','Test123!','nglish')