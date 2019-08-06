INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00000','YES','Invalid Exception.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00000' AND  Message = 'Invalid Exception.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00001','YES','Invalid EMail ID.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00001' AND Message = 'Invalid EMail ID.'
) LIMIT 1;


INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00002','YES','Invalid Phone Number.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00002' AND Message = 'Invalid Phone Number.'
) LIMIT 1;


INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00003','YES','Phone Number Already Exists.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00003' AND Message = 'Phone Number Already Exists.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00004','YES','EMail ID Already Exists.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00004' AND Message = 'EMail ID Already Exists.'
) LIMIT 1;


INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00005','YES','User Policy cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00005' AND Message = 'User Policy cannot be empty.'
) LIMIT 1;


INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00006','NO','Login successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00006' AND  Message = 'Login successfully.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00007','NO','Signup successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00007' AND  Message = 'Signup successfully.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00008','YES','Invalid username/password.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00008' AND  Message = 'Invalid username/password.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00009','YES','Invalid language.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00009' AND  Message = 'Invalid language.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00010','YES','Username cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00010' AND  Message = 'Username cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00011','YES','Password cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00011' AND  Message = 'Password cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00012','YES','Language cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00012' AND  Message = 'Language cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00013','YES','password/confirm password not match.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00013' AND  Message = 'password/confirm password not match.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00014','YES','Plan ID cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00014' AND  Message = 'Plan ID cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00015','YES','First Name cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00015' AND  Message = 'First Name cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00016','YES','Last Name cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00016' AND  Message = 'Last Name cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00017','YES','Confirm Password cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00017' AND  Message = 'Confirm Password cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00018','YES','EMail ID cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00018' AND  Message = 'EMail ID cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00019','YES','Phone Number cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00019' AND  Message = 'Phone Number cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00020','YES','Plan ID cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00020' AND  Message = 'Plan ID cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00021','YES','Invalid Plan ID.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00021' AND  Message = 'Invalid Plan ID.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00022','YES','Source cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00022' AND  Message = 'Source cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00023','YES','Template cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00023' AND  Message = 'Template cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00024','YES','Message cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00024' AND  Message = 'Message cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00025','YES','Invalid Template.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00025' AND  Message = 'Invalid Template.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00026','YES','API Name cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00026' AND  Message = 'API Name cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00027','YES','Invalid API Name.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00027' AND  Message = 'Invalid API Name.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00028','NO','URL generation successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00028' AND  Message = 'URL generation successfully.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00029','NO','Template return successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00029' AND  Message = 'Template return successfully.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00030','NO','Message sent successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00030' AND  Message = 'Message sent successfully.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00031','YES','Unable to sent message, Please try some time.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00031' AND  Message = 'Unable to sent message, Please try some time.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00032','YES','Password length should be at least eight character.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00032' AND  Message = 'Password length should be at least eight character.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00033','YES','Invalid Source.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00033' AND  Message = 'Invalid Source.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00034','YES','Invalid User Policy.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00034' AND Message = 'Invalid User Policy.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00035','NO','User created successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00035' AND  Message = 'User created successfully.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00036','YES','Password must contain at least 1 lowercase letter.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00036' AND  Message = 'Password must contain at least 1 lowercase letter.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00037','YES','Password must contain at least 1 uppercase letter.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00037' AND  Message = 'Password must contain at least 1 uppercase letter.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00038','YES','Password must contain at least 1 digit.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00038' AND  Message = 'Password must contain at least 1 digit.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00039','YES','Password must contain at least 1 special character form ( @,%,!,#,$,:,(,),{,},~,_ ).','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00039' AND  Message = 'Password must contain at least 1 special character form ( @,%,!,#,$,:,(,),{,},~,_ ).'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00040','YES','OTP cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00040' AND  Message = 'OTP cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00041','YES','Invalid OTP.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00041' AND  Message = 'Invalid OTP.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00042','YES','User not exists.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00042' AND  Message = 'User not exists.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00043','NO','Password update successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00043' AND  Message = 'Password update successfully.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00044','YES','Username cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00044' AND  Message = 'Username cannot be empty.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00045','YES','Username Already Exists.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00045' AND  Message = 'Username Already Exists.'
) LIMIT 1;

INSERT INTO MessageMaster (Code,ErrorFound, Message, version, language)
SELECT * FROM (SELECT 'ERR00046','YES','OTP is expired.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT Code FROM MessageMaster WHERE Code = 'ERR00046' AND  Message = 'OTP is expired.'
) LIMIT 1;