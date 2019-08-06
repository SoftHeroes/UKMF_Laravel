DROP procedure IF EXISTS USP_markLogin;
DELIMITER $$
CREATE PROCEDURE USP_markLogin ( IN p_username VARCHAR(255),IN p_loginFail varchar(255) )
proc_Call:BEGIN
  DECLARE RowCount INT DEFAULT 0;
  DECLARE ErrorNumber INT;
  DECLARE ErrorMessage VARCHAR(1000);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
      SELECT Code,ErrorFound,Message,version,language,ErrorMessage FROM MessageMaster WHERE Code = 'ERR00000' AND language = 'English';
      ROLLBACK;
    END;

  IF NOT EXISTS( SELECT 1 FROM userInformation WHERE username = p_username OR phoneNumber = p_username OR emailID = p_username ) THEN
    LEAVE proc_Call;
  END IF;
  
  IF(p_loginFail = 'NO' ) THEN
    BEGIN
      START TRANSACTION;
    
        UPDATE userinformation SET InvaildUpdateAttemptsCount = 0
          WHERE username = p_username OR phoneNumber = p_username OR emailID = p_username ;
      
      COMMIT WORK;
    END;
    ELSE

      START TRANSACTION;
    
      UPDATE userinformation UserInfo
        JOIN userpolicy UP ON UP.uniqueID = UserInfo.UserPolicyID
        SET UserInfo.InvaildUpdateAttemptsCount =  ( UserInfo.InvaildUpdateAttemptsCount + 1 ),
        UserInfo.isLock = 
         CASE WHEN UserInfo.InvaildUpdateAttemptsCount > UP.invaildUpdateAttemptsAllowed 
            THEN 1 
            ELSE 0 
         END
        WHERE UserInfo.username = p_username OR UserInfo.phoneNumber = p_username OR UserInfo.emailID = p_username;
      
      COMMIT WORK;

  END IF;

END$$


DELIMITER ;

/*
call USP_markLogin('superUser','YES');
  */