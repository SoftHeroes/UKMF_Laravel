DROP procedure IF EXISTS USP_insertIntoThirdPartyAPISetup;

DELIMITER $$
CREATE PROCEDURE USP_insertIntoThirdPartyAPISetup ( 
  IN p_APIName VARCHAR(255),
  IN p_server VARCHAR(255),
  IN p_resource VARCHAR(255),
  IN p_environment VARCHAR(255),
  IN p_method VARCHAR(255),
  IN p_userID VARCHAR(255),
  IN p_password VARCHAR(255),
  IN p_accessCode VARCHAR(255),
  IN p_param1 VARCHAR(255),
  IN p_value1 VARCHAR(255),
  IN p_param2 VARCHAR(255),
  IN p_value2 VARCHAR(255),
  IN p_tranAmountInputTag VARCHAR(255),
  IN p_circleIdInputTag VARCHAR(255),
  IN p_tranIDInputTag VARCHAR(255),
  IN p_numberInputTag VARCHAR(255),
  IN p_providerIdInputTag VARCHAR(255),
  IN p_providerIdOutputTag VARCHAR(255),
  IN p_providerNameOutputTag VARCHAR(255),
  IN p_providerImageOutputTag VARCHAR(255),
  IN p_serviceCodeOutputTag VARCHAR(255),
  IN p_serviceNameOutputTag VARCHAR(255),
  IN p_circleIdOutputTag VARCHAR(255),
  IN p_circleNameOutputTag VARCHAR(255),
  IN p_commissionProfitOutputTag VARCHAR(255),
  IN p_serviceStatusOutputTag VARCHAR(255),
  IN p_tranIDOutputTag VARCHAR(255),
  IN p_tranStatusOutputTag VARCHAR(255),
  IN p_tranDateOutputTag VARCHAR(255),
  IN p_tranAmountOutputTag VARCHAR(255),
  IN p_operatorRefOutputTag VARCHAR(255),
  IN p_responseCodeOutputTag VARCHAR(255),
  IN p_responseMessageOutputTag VARCHAR(255),
  IN p_walletBalanceOutputTag VARCHAR(255)
  )
proc_Call:BEGIN
  
  DECLARE ErrorMessage VARCHAR(1000);
  DECLARE ErrorNumber INT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT  Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster  WHERE Code = 'ERR00000' AND language = 'English';
      ROLLBACK;
    END;
  
  START TRANSACTION;
    INSERT INTO ThirdPartyAPISetup(
        APIName,
        server,
        resource,
        environment,
        method,
        userID,
        password,
        accessCode,
        param1,
        value1,
        param2,
        value2,
        tranAmountInputTag,
        circleIdInputTag,
        tranIDInputTag,
        numberInputTag,
        providerIdInputTag,
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
        walletBalanceOutputTag)
      SELECT * FROM (SELECT
        p_APIName AS APIName,
        p_server AS server,
        p_resource AS resource,
        p_environment AS environment,
        p_method AS method,
        p_userID AS userID,
        AES_DECRYPT(p_password,p_APIName) AS password,
        AES_DECRYPT(p_accessCode,p_APIName) AS accessCode,
        p_param1 AS param1,
        p_value1 AS value1,
        p_param2 AS param2,
        p_value2 AS value2,
        p_tranAmountInputTag AS tranAmountInputTag,
        p_circleIdInputTag AS circleIdInputTag,
        p_tranIDInputTag AS tranIDInputTag,
        p_numberInputTag AS numberInputTag,
        p_providerIdInputTag AS providerIdInputTag,
        p_providerIdOutputTag AS providerIdOutputTag,
        p_providerNameOutputTag AS providerNameOutputTag,
        p_providerImageOutputTag AS providerImageOutputTag,
        p_serviceCodeOutputTag AS serviceCodeOutputTag,
        p_serviceNameOutputTag AS serviceNameOutputTag,
        p_circleIdOutputTag AS circleIdOutputTag,
        p_circleNameOutputTag AS circleNameOutputTag,
        p_commissionProfitOutputTag AS commissionProfitOutputTag,
        p_serviceStatusOutputTag AS serviceStatusOutputTag,
        p_tranIDOutputTag AS tranIDOutputTag,
        p_tranStatusOutputTag AS tranStatusOutputTag,
        p_tranDateOutputTag AS tranDateOutputTag,
        p_tranAmountOutputTag AS tranAmountOutputTag,
        p_operatorRefOutputTag AS operatorRefOutputTag,
        p_responseCodeOutputTag AS responseCodeOutputTag,
        p_responseMessageOutputTag AS responseMessageOutputTag,
        p_walletBalanceOutputTag AS walletBalanceOutputTag
        ) 
       AS Temp 
      WHERE NOT EXISTS (SELECT 1 FROM ThirdPartyAPISetup WHERE APIName = p_APIName AND environment = p_environment ) LIMIT 1;
  COMMIT WORK;
  
      SELECT  Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster  WHERE Code = 'ERR00047' AND language = 'English';

  END$$
DELIMITER ;

/*
call USP_insertIntoThirdPartyAPISetup(
  'APIName',
  'server',
  'resource',
  'environment',
  'method',
  'userID',
  'password',
  'accessCode',
  'param1',
  'value1',
  'param2',
  'value2',
  'tranAmountInputTag',
  'circleIdInputTag',
  'tranIDInputTag',
  'numberInputTag',
  'providerIdInputTag',
  'providerIdOutputTag',
  'providerNameOutputTag',
  'providerImageOutputTag',
  'serviceCodeOutputTag',
  'serviceNameOutputTag',
  'circleIdOutputTag',
  'circleNameOutputTag',
  'commissionProfitOutputTag',
  'serviceStatusOutputTag',
  'tranIDOutputTag',
  'tranStatusOutputTag',
  'tranDateOutputTag',
  'tranAmountOutputTag',
  'operatorRefOutputTag',
  'responseCodeOutputTag',
  'responseMessageOutputTag',
  'walletBalanceOutputTag' );
*/
