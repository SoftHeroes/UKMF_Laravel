DROP FUNCTION IF EXISTS isEmail;
  
CREATE FUNCTION isEmail(val varchar(255))
  RETURNS tinyint(1)
  DETERMINISTIC
return val regexp '^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a??-zA-Z]{2,4}$'

-- SELECT isEmail('vf@jv.cd')
 