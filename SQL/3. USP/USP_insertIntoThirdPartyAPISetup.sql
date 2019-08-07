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
  IN p_param3 VARCHAR(255),
  IN p_value3 VARCHAR(255),
  IN p_param4 VARCHAR(255),
  IN p_value4 VARCHAR(255),
  IN p_param5 VARCHAR(255),
  IN p_value5 VARCHAR(255),
  IN p_param6 VARCHAR(255),
  IN p_value6 VARCHAR(255),
  IN p_param7 VARCHAR(255),
  IN p_value7 VARCHAR(255),
  IN p_providerIdTag VARCHAR(255),
  IN p_providerNameTag VARCHAR(255),
  IN p_providerImageTag VARCHAR(255),
  IN p_serviceCodeTag VARCHAR(255),
  IN p_serviceNameTag VARCHAR(255),
  IN p_circleIdTag VARCHAR(255),
  IN p_circleNameTag VARCHAR(255),
  IN p_commissionProfitTag VARCHAR(255),
  IN p_tranIDTag VARCHAR(255),
  IN p_tranStatusTag VARCHAR(255),
  IN p_balanceAmountTag VARCHAR(255),
  IN p_responseCodeTag VARCHAR(255),
  IN p_responseMessageTag VARCHAR(255)
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
        param3,
        value3,
        param4,
        value4,
        param5,
        value5,
        param6,
        value6,
        param7,
        value7,
        providerIdTag,
        providerNameTag,
        providerImageTag,
        serviceCodeTag,
        serviceNameTag,
        circleIdTag,
        circleNameTag,
        commissionProfitTag,
        tranIDTag,
        tranStatusTag,
        balanceAmountTag,
        responseCodeTag,
        responseMessageTag)
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
        p_param3 AS param3,
        p_value3 AS value3,
        p_param4 AS param4,
        p_value4 AS value4,
        p_param5 AS param5,
        p_value5 AS value5,
        p_param6 AS param6,
        p_value6 AS value6,
        p_param7 AS param7,
        p_value7 AS value7,
        p_providerIdTag AS providerIdTag,
        p_providerNameTag AS providerNameTag,
        p_providerImageTag AS providerImageTag,
        p_serviceCodeTag AS serviceCodeTag,
        p_serviceNameTag AS serviceNameTag,
        p_circleIdTag AS circleIdTag,
        p_circleNameTag AS circleNameTag,
        p_commissionProfitTag AS commissionProfitTag,
        p_tranIDTag AS tranIDTag,
        p_tranStatusTag AS tranStatusTag,
        p_balanceAmountTag AS balanceAmountTag,
        p_responseCodeTag AS responseCodeTag,
        p_responseMessageTag AS responseMessageTag
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
  'param3',
  'value3',
  'param4',
  'value4',
  'param5',
  'value5',
  'param6',
  'value6',
  'param7',
  'value7',
  'providerIdTag',
  'providerNameTag',
  'providerImageTag',
  'serviceCodeTag',
  'serviceNameTag',
  'circleIdTag',
  'circleNameTag',
  'commissionProfitTag',
  'tranIDTag',
  'tranStatusTag',
  'balanceAmountTag',
  'responseCodeTag',
  'responseMessageTag' );
*/
