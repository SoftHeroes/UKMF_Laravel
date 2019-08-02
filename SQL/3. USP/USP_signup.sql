
DROP procedure IF EXISTS USP_signup;

DELIMITER $$
CREATE PROCEDURE USP_signup ( 
    IN p_Password VARCHAR(255),
    IN p_ConfirmPassword VARCHAR(255),
    IN p_FirstName VARCHAR(255),
    IN p_MiddleName VARCHAR(255),
    IN p_LastName VARCHAR(255),
    IN p_EmailID VARCHAR(255),
    IN p_PhoneNumber VARCHAR(255),
    IN p_PlanID INT,
    IN p_Language VARCHAR(255),
    IN p_Source VARCHAR(255)
  )
proc_Call:BEGIN
	DECLARE RowCount INT DEFAULT 0;
  DECLARE ErrorNumber INT;
  DECLARE ErrorMessage VARCHAR(1000);
  DECLARE op_UUID VARCHAR(64);
      
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00000' AND language = p_Language;
      ROLLBACK;
    END;


  -- Language check block : START
  IF ( p_Language IS NULL OR TRIM(p_Language) = '' ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00012' AND language = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languageLookup where language = p_Language) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00009' AND language = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
	
  -- Input check block : START
  IF(  p_Password IS NULL OR TRIM(p_Password) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00011' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_ConfirmPassword IS NULL OR TRIM(p_ConfirmPassword) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00017' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_FirstName IS NULL OR TRIM(p_FirstName) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00015' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_LastName IS NULL OR TRIM(p_LastName) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00016' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_EmailID IS NULL OR TRIM(p_EmailID) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00018' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_PhoneNumber IS NULL OR TRIM(p_PhoneNumber) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00019' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  p_PlanID IS NULL OR TRIM(p_PlanID) = '' ) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00020' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF (STRCMP( p_Password,p_ConfirmPassword )) THEN
      BEGIN
          SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00013' AND language = p_Language;
          LEAVE proc_Call;
      END;
  ELSEIF(  LENGTH(p_Password) < 8 ) THEN
    BEGIN
        SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00032' AND language = p_Language;
        LEAVE proc_Call;
    END;
  ELSEIF (p_Source IS NULL OR TRIM(p_Source) = '') THEN
    BEGIN
        SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00022' AND language = p_Language;
        LEAVE proc_Call;
    END;


  END IF;
	-- Input check block : END

	-- Email format valdation block : START
  IF( !isEmail(p_EmailID) ) THEN 
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00001' AND language = p_Language;
      LEAVE proc_Call;
    END;
  -- Email format valdation block : END

  -- Phone Number valdation block : START
  ELSEIF(  !isNumeric(p_PhoneNumber) OR LENGTH(p_PhoneNumber) != 10 ) THEN
    BEGIN
        SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00002' AND language = p_Language;
        LEAVE proc_Call;
    END;
  -- Phone Number valdation block : END
  END IF;
	
  -- Plan ID valdation block : START
  SET RowCount = ( SELECT 1 FROM CustomerPlan WHERE uniqueID = p_PlanID);
  IF(  RowCount = 0 OR RowCount IS NULL ) THEN
    BEGIN
        SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00021' AND language = p_Language;
        LEAVE proc_Call;
    END;
  END IF;
  -- Plan ID valdation block : END

	-- Duplicate validation block : START
	SET RowCount = ( SELECT 1 FROM Customer WHERE emailID = p_EmailID);
    
  IF(RowCount > 0 ) THEN 
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00004' AND language = p_Language;
      LEAVE proc_Call;
    END;
  END IF;

	SET RowCount = ( SELECT 1 FROM Customer WHERE phoneNumber = p_PhoneNumber);
    
  IF(RowCount > 0 ) THEN 
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00003' AND language = p_Language;
      LEAVE proc_Call;
    END;
  END IF;
	-- Duplicate validation block : END

  -- Customer Account creation block : START

  START TRANSACTION;
  SET op_UUID = UUID();
    INSERT INTO Customer(
      password,
      firstName,
      middleName,
      lastName, 
      emailID, 
      phoneNumber,
      creationDatetime,
      PlanID,
      UUID
    ) 
    VALUES (
      AES_ENCRYPT(p_Password,CAST(p_PhoneNumber as CHAR(10)) ),
      p_FirstName,
      p_MiddleName,
      p_LastName,
      p_EmailID,
      p_PhoneNumber,
      CURRENT_TIMESTAMP(),
      p_PlanID,
      op_UUID
    );
  COMMIT WORK;
  -- Customer Account creation block : END

  SELECT Code,ErrorFound,Message,version,language,ErrorMessage,p_PhoneNumber CustomerPhoneNumber,p_EmailID CustomerEmailID,op_UUID as CustomerUUID FROM MessageMaster WHERE Code = 'ERR00007' AND language = p_Language;

END$$

DELIMITER ;

/*
call USP_signup('Test123!','Test123!','dcd',null,'LName','singhsapna144@gmail.com','9630054749',1,'English','UHG');
*/