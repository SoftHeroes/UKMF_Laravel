DROP procedure IF EXISTS USP_getRechargeAPIURL;

DELIMITER $$
CREATE PROCEDURE USP_getRechargeAPIURL ( 
    IN p_APIName VARCHAR(255),
    IN p_TranAmount VARCHAR(255),
    IN p_CircleId VARCHAR(255),
    IN p_TranID VARCHAR(255),
    IN p_ServiceIDNumber VARCHAR(255),
    IN p_ProviderId VARCHAR(255),
    IN p_Source VARCHAR(255),
    IN p_Language VARCHAR(255)
  )
proc_Call:BEGIN

  DECLARE isTranAmountValid tinyint(1) DEFAULT 0;
  DECLARE isCircleIdValid tinyint(1) DEFAULT 0;
  DECLARE isTranIDValid tinyint(1) DEFAULT 0;
  DECLARE isServiceIDNumberValid tinyint(1) DEFAULT 0;
  DECLARE isProviderIdValid tinyint(1) DEFAULT 0;

  -- Output varibles : START
  DECLARE op_Environment VARCHAR(200);
  DECLARE RowCount INT DEFAULT NULL;
  DECLARE ErrorNumber INT;
  DECLARE op_ErrorMessage VARCHAR(1000);
  DECLARE op_URL VARCHAR(5000) DEFAULT '';
  DECLARE op_Method VARCHAR(255);  DECLARE op_UserID varchar(255);
  DECLARE op_Password varchar(255);
  DECLARE op_AccessCode varchar(255);
  DECLARE op_APIName varchar(255);
  DECLARE op_APIID INT(10);
  DECLARE op_providerIdOutputTag varchar(255);
  DECLARE op_providerNameOutputTag varchar(255);
  DECLARE op_providerImageOutputTag varchar(255);
  DECLARE op_serviceCodeOutputTag varchar(255);
  DECLARE op_serviceNameOutputTag varchar(255);
  DECLARE op_circleIdOutputTag varchar(255);
  DECLARE op_circleNameOutputTag varchar(255);
  DECLARE op_commissionProfitOutputTag varchar(255);
  DECLARE op_serviceStatusOutputTag varchar(255);
  DECLARE op_tranIDOutputTag varchar(255);
  DECLARE op_tranStatusOutputTag varchar(255);
  DECLARE op_tranDateOutputTag varchar(255);
  DECLARE op_tranAmountOutputTag varchar(255);
  DECLARE op_operatorRefOutputTag varchar(255);
  DECLARE op_responseCodeOutputTag varchar(255);
  DECLARE op_responseMessageOutputTag varchar(255);
  DECLARE op_walletBalanceOutputTag varchar(255);
  -- Output varibles : END

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,op_ErrorMessage = MESSAGE_TEXT;
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00000' AND language = p_Language;
    ROLLBACK;
  END;


  SET op_Environment  = (SELECT envName FROM APP_ENV LIMIT 1); -- Getting op_Environment value
  

  -- Language check block : START
  IF (stringIsNull(p_Language)) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00012' AND language = 'English';
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS (select 1 from languageLookup where language = p_Language) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00009' AND language = 'English';
    LEAVE proc_Call;
  END;
  END IF;
  -- Language check block : END
	
  -- Input check block : START
  IF( stringIsNull(p_Source)) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00022' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS(  SELECT 1 FROM lookUp WHERE name = p_Source AND category = 'source' AND languageID =  getLanguageID(p_Language)  ) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00033' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF( stringIsNull(p_APIName)) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00026' AND language = p_Language;
    LEAVE proc_Call;
  END;
  ELSEIF NOT EXISTS( SELECT 1 FROM ThirdPartyAPISetup WHERE APIName = p_APIName AND environment = op_Environment AND deletedAt IS NULL) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00027' AND language = p_Language;
    LEAVE proc_Call;
  END;
  END IF;
	-- Input check block : END
  
  -- Check parameter based on API Name block : START

  SELECT 
    ( CASE WHEN tranAmountInputTag IS NULL THEN 0 ELSE 1 END ) AS isTranAmountValid, 
    ( CASE WHEN circleIdInputTag IS NULL THEN 0 ELSE 1 END ) AS isCircleIdValid, 
    ( CASE WHEN tranIDInputTag IS NULL THEN 0 ELSE 1 END ) AS isTranIDValid, 
    ( CASE WHEN serviceIDNumberInputTag IS NULL THEN 0 ELSE 1 END ) AS isServiceIDNumberValid, 
    ( CASE WHEN providerIdInputTag IS NULL THEN 0 ELSE 1 END ) AS isProviderIdValid
    INTO 
    isTranAmountValid,
    isCircleIdValid,
    isTranIDValid,
    isServiceIDNumberValid,
    isProviderIdValid
  FROM ThirdPartyAPISetup WHERE APIName = p_APIName;

  IF ( isTranAmountValid AND p_TranAmount IS NULL ) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00048' AND language = p_Language;
    LEAVE proc_Call;
  END;
  END IF;

  IF ( isCircleIdValid AND p_CircleId IS NULL) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00049' AND language = p_Language;
    LEAVE proc_Call;
  END;
  END IF;

  IF ( isTranIDValid AND p_TranID IS NULL) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00050' AND language = p_Language;
    LEAVE proc_Call;
  END;
  END IF;

  IF ( isServiceIDNumberValid AND p_ServiceIDNumber IS NULL ) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00051' AND language = p_Language;
    LEAVE proc_Call;
  END;
  END IF;

  IF ( isProviderIdValid AND p_ProviderId IS NULL ) THEN
  BEGIN
    SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00052' AND language = p_Language;
    LEAVE proc_Call;
  END;
  END IF;
  -- Check parameter based on API Name block : END


  -- op_URL Generation block : START 
  SELECT CONCAT((CASE WHEN server IS NULL THEN '' ELSE TRIM(server) END ),
                (CASE WHEN resource IS NULL THEN '' ELSE TRIM(resource) END ),
                (CASE WHEN param1 IS NULL THEN '' ELSE CONCAT(TRIM(param1),'=',TRIM(value1),'&') END ),
                (CASE WHEN param2 IS NULL THEN '' ELSE CONCAT(TRIM(param2),'=',TRIM(value2),'&') END ),
                (CASE WHEN tranAmountInputTag IS NULL THEN '' ELSE CONCAT(TRIM(tranAmountInputTag),'=',TRIM(p_TranAmount),'&') END ),
                (CASE WHEN circleIdInputTag IS NULL THEN '' ELSE CONCAT(TRIM(circleIdInputTag),'=',TRIM(p_CircleId),'&') END ),
                (CASE WHEN tranIDInputTag IS NULL THEN '' ELSE CONCAT(TRIM(tranIDInputTag),'=',TRIM(p_TranID),'&') END ),
                (CASE WHEN serviceIDNumberInputTag IS NULL THEN '' ELSE CONCAT(TRIM(serviceIDNumberInputTag),'=',TRIM(p_ServiceIDNumber),'&') END ),
                (CASE WHEN providerIdInputTag IS NULL THEN '' ELSE CONCAT(TRIM(providerIdInputTag),'=',TRIM(p_ProviderId),'&') END )
          )  AS op_URL, 
          method,
          userID,
          AES_DECRYPT(password,APIName) AS password,
          AES_DECRYPT(accessCode,APIName) AS accessCode,
          providerIdOutputTag,
          providerNameOutputTag,
          providerImageOutputTag,
          serviceCodeOutputTag,
          serviceNameOutputTag,
          circleIdOutputTag,
          circleNameOutputTag,
          commissionProfitOutputTag,
          serviceStatusOutputTag,
          tranIDOutputTag,
          tranStatusOutputTag,
          tranDateOutputTag,
          tranAmountOutputTag,
          operatorRefOutputTag,
          responseCodeOutputTag,
          responseMessageOutputTag,
          walletBalanceOutputTag,
          APIName,
          uniqueID
  INTO 
    op_URL,
    op_Method,
    op_UserID,
    op_Password,
    op_AccessCode,
    op_providerIdOutputTag,
    op_providerNameOutputTag,
    op_providerImageOutputTag,
    op_serviceCodeOutputTag,
    op_serviceNameOutputTag,
    op_circleIdOutputTag,
    op_circleNameOutputTag,
    op_commissionProfitOutputTag,
    op_serviceStatusOutputTag,
    op_tranIDOutputTag,
    op_tranStatusOutputTag,
    op_tranDateOutputTag,
    op_tranAmountOutputTag,
    op_operatorRefOutputTag,
    op_responseCodeOutputTag,
    op_responseMessageOutputTag,
    op_walletBalanceOutputTag,
    op_APIName,
    op_APIID
  FROM ThirdPartyAPISetup WHERE APIName = p_APIName AND  environment = op_Environment AND deletedAt IS NULL;
  

  SELECT  Code,ErrorFound,Message,version,language,op_ErrorMessage as ErrorMessage,op_URL as URL,op_Method as Method,op_UserID as UserID,op_Password as Password,op_AccessCode as AccessCode,op_providerIdOutputTag AS providerIdOutputTag,op_providerNameOutputTag AS providerNameOutputTag,op_providerImageOutputTag AS providerImageOutputTag,op_serviceCodeOutputTag AS serviceCodeOutputTag,op_serviceNameOutputTag AS serviceNameOutputTag,op_circleIdOutputTag AS circleIdOutputTag,op_circleNameOutputTag AS circleNameOutputTag,op_commissionProfitOutputTag AS commissionProfitOutputTag,op_serviceStatusOutputTag AS serviceStatusOutputTag,op_tranIDOutputTag AS tranIDOutputTag,op_tranStatusOutputTag AS tranStatusOutputTag,op_tranDateOutputTag AS tranDateOutputTag,op_tranAmountOutputTag AS tranAmountOutputTag,op_operatorRefOutputTag AS operatorRefOutputTag,op_responseCodeOutputTag AS responseCodeOutputTag,op_responseMessageOutputTag AS responseMessageOutputTag, op_walletBalanceOutputTag AS walletBalanceOutputTag,op_APIName as APIName,op_APIID as APIID FROM MessageMaster  WHERE Code = 'ERR00028' AND language = p_Language;
  -- op_URL Generation block : START
  
END$$

DELIMITER ;

/*
call USP_getRechargeAPIURL('rechargeBillPayment','10','16',NULL,'9630054749','1','Web','English');
*/
