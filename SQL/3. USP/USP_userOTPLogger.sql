
DROP procedure IF EXISTS USP_userOTPLogger ;

DELIMITER $$
CREATE PROCEDURE USP_userOTPLogger ( 
    IN p_sendTo VARCHAR(255),
    IN p_OTP VARCHAR(255)
  )
proc_Call:BEGIN
  DECLARE ErrorNumber INT;
  DECLARE ErrorMessage VARCHAR(1000);
      
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 ErrorNumber = MYSQL_ERRNO,ErrorMessage = MESSAGE_TEXT;
    SELECT 'YES' ErrorFound ,ErrorMessage Message;
    ROLLBACK;
  END;


  -- Parameter validation block : START
  IF (stringIsNull(p_sendTo)) THEN
  BEGIN
    SELECT 'YES' ErrorFound ,'sendTo is null' Message;
  END;
  ELSEIF (stringIsNull(p_OTP)) THEN
  BEGIN
    SELECT 'YES' ErrorFound ,'OTP is null' Message;
    LEAVE proc_Call;
  END;
  END IF;
  -- Parameter validation block : END

  -- Insertion block into User OTP Log  : START
  START TRANSACTION;
  
    DELETE FROM userOTPLog WHERE userPhoneNumber = p_sendTo;
    
    INSERT INTO userOTPLog( userPhoneNumber, OTP, sendTime ) 
    VALUES ( p_sendTo,p_OTP,CURRENT_TIMESTAMP() );

  COMMIT WORK;
      
  SELECT 'NO' ErrorFound ,'OTP save successfully.' Message;
  -- Insertion block into User OTP Log  : START

END$$

DELIMITER ;

/*
call USP_userOTPLogger ('9074200979','123456');
*/