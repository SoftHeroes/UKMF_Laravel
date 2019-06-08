FUNCTION isnumeric(val varchar(1024))
  RETURNS tinyint(1)
  DETERMINISTIC
return val regexp '^(-|\\+)?([0-9]+\\.[0-9]*|[0-9]*\\.[0-9]+|[0-9]+)$'