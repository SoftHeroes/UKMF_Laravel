DROP procedure IF EXISTS USP_searchAccount;
DELIMITER $$
CREATE PROCEDURE USP_searchAccount ( 
  IN p_FirstName VARCHAR(255),
  IN p_MiddleName VARCHAR(255),
  IN p_LastName VARCHAR(255),
  IN p_EmailAddress VARCHAR(255),
  IN p_PhoneNumber VARCHAR(255),
  IN p_PlainId bigint(20),
  IN p_UUID VARCHAR(255),
  IN p_BatchSize INT,
  IN p_PageNumber INT,
  IN p_Source VARCHAR(255),
  IN p_Language VARCHAR(255)
)
proc_Call:BEGIN

  DECLARE ErrorNumber INT;
  DECLARE OffsetValue INT;
  DECLARE ErrorMessage VARCHAR(1000);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00000' AND language = p_Language;
      ROLLBACK;
    END;

  IF(p_PlainId = 0) THEN
    SET p_PlainId = NULL;
  END IF;

  -- Language check block : START
  IF (stringIsNull(p_Language)) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00012' AND language = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languageLookup where language = p_Language) THEN
    BEGIN
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00009' AND language = 'English';
      LEAVE proc_Call;
    END;
  END IF;
  -- Language check block : END
  
  -- Input check block : START
  IF(stringIsNull(p_Source)) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00010' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF (stringIsNull(p_BatchSize)) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00053' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF (stringIsNull(p_PageNumber)) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00054' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF ( !isNumeric(p_BatchSize) ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00055' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF ( !isNumeric(p_PageNumber) ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00056' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS( SELECT 1 FROM lookUp WHERE name = p_Source AND category = 'source' AND languageID =  getLanguageID(p_Language) ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00033' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS( SELECT 1 FROM lookUp WHERE name = p_Source AND category = 'source' AND languageID =  getLanguageID(p_Language) ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00033' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF ( stringIsNull(p_FirstName) AND stringIsNull(p_MiddleName) AND stringIsNull(p_LastName) AND stringIsNull(p_EmailAddress) AND stringIsNull(p_PhoneNumber) AND ISNULL(p_PlainId) AND stringIsNull(p_UUID) ) THEN
  BEGIN
    SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00057' AND language = p_Language;
    LEAVE proc_Call;
  END;
  END IF;
  -- Input check block : END
  SET OffsetValue = (p_PageNumber - 1) * p_BatchSize;

  SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00058' AND language = p_Language;
  
  SELECT * FROM Customer 
    WHERE 
      (
        firstName LIKE CONCAT('%',p_FirstName,'%') OR
        middleName LIKE CONCAT('%',p_MiddleName,'%') OR
        lastName LIKE CONCAT('%',p_LastName,'%') OR
        emailID LIKE CONCAT('%',p_EmailAddress,'%') OR
        phoneNumber LIKE CONCAT('%',p_PhoneNumber,'%')
      )
      AND PlanID = IFNULL(p_PlainId,PlanID) AND UUID = IFNULL(p_UUID,UUID)
    LIMIT p_BatchSize OFFSET OffsetValue;

END$$

DELIMITER ;

/*
call USP_searchAccount('h',NULL,'Jobanput',NULL,NULL,NULL,NULL,5,1,'Web','English');
  */