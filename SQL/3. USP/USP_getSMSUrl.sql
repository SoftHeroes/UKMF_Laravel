DROP procedure IF EXISTS `USP_getSMSUrl`;

DELIMITER $$
CREATE PROCEDURE `USP_getSMSUrl` ( 
    IN p_Password VARCHAR(255),
    IN p_ConfirmPassword VARCHAR(255),
    IN p_FirstName VARCHAR(255),
    IN p_MiddleName VARCHAR(255),
    IN p_LastName VARCHAR(255),
    IN p_EmailID VARCHAR(255),
    IN p_PhoneNumber VARCHAR(255),
    IN p_PlanID INT,
    IN p_Language VARCHAR(255)
  )
proc_Call:BEGIN
	DECLARE RowCount INT DEFAULT 0;
  DECLARE ErrorNumber INT;
  DECLARE ErrorMessage VARCHAR(1000);
    
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00000' AND `language` = p_Language;
      ROLLBACK;
    END;


  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00012' AND `language` = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languagelookup where language = p_Language) THEN
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00009' AND `language` = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
	
  -- Input check block : START
  IF(  p_Password IS NULL OR TRIM(p_Password) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00011' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_ConfirmPassword IS NULL OR TRIM(p_ConfirmPassword) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00017' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_FirstName IS NULL OR TRIM(p_FirstName) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00015' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_LastName IS NULL OR TRIM(p_LastName) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00016' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_EmailID IS NULL OR TRIM(p_EmailID) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00018' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_PhoneNumber IS NULL OR TRIM(p_PhoneNumber) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00019' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_PlanID IS NULL OR TRIM(p_PlanID) = '' ) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00020' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF (STRCMP( p_Password,p_ConfirmPassword )) THEN
      BEGIN
          SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00013' AND `language` = p_Language;
          LEAVE proc_Call;
      END;
  END IF;
	-- Input check block : END

	-- Email format valdation block : START
  IF( p_EmailID NOT RLIKE '^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a??-zA-Z]{2,4}$' ) THEN 
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00001' AND `language` = p_Language;
      LEAVE proc_Call;
    END;
  -- Email format valdation block : END

  -- Phone Number valdation block : START
  ELSEIF(  !isnumeric(p_PhoneNumber) OR LENGTH(p_PhoneNumber) != 10 ) THEN
    BEGIN
        SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00002' AND `language` = p_Language;
        LEAVE proc_Call;
    END;
  -- Phone Number valdation block : END
  END IF;
	
  -- Plan ID valdation block : START
  SET RowCount = ( SELECT 1 FROM `customerplan` WHERE u_ID = p_PlanID);
  IF(  RowCount = 0 ) THEN
    BEGIN
        SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00021' AND `language` = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
  -- Plan ID valdation block : END

	-- Duplicate validation block : START
	SET RowCount = ( SELECT 1 FROM `customer` WHERE emailID = p_EmailID);
    
  IF(RowCount > 0 ) THEN 
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00004' AND `language` = p_Language;
      LEAVE proc_Call;
    END;
  END IF;

	SET RowCount = ( SELECT 1 FROM `customer` WHERE phoneNumber = p_Password);
    
  IF(RowCount > 0 ) THEN 
    BEGIN
      SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00003' AND `language` = p_Language;
      LEAVE proc_Call;
    END;
  END IF;
	-- Duplicate validation block : END

  -- Customer Account creation block : START

  START TRANSACTION;
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
      SHA1(p_Password),
      p_FirstName,
      p_MiddleName,
      p_LastName,
      p_EmailID,
      p_PhoneNumber,
      CURRENT_TIMESTAMP(),
      p_PlanID
    );
  COMMIT WORK;
  -- Customer Account creation block : END

  SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,ErrorMessage FROM `messagemaster` WHERE `Code` = 'ERR00007' AND `language` = p_Language;

END$$

DELIMITER ;

/*
call USP_signup('Test123!','Test123!','FName',null,'LName','Suffddbhacm@UKMF.com','1245789563',1,'English');
*/