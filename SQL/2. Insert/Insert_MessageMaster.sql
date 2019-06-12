INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00000','YES','Invalid Exception.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00000' AND  `Message` = 'Invalid Exception.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00001','YES','Invalid EMail ID.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00001' AND `Message` = 'Invalid EMail ID.'
) LIMIT 1;


INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00002','YES','Invalid Phone Number.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00002' AND `Message` = 'Invalid Phone Number.'
) LIMIT 1;


INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00003','YES','Phone Number Already Exists.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00003' AND `Message` = 'Phone Number Already Exists.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00004','YES','EMail ID Already Exists.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00004' AND `Message` = 'EMail ID Already Exists.'
) LIMIT 1;


INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00005','YES','User Policy cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00005' AND `Message` = 'User Policy cannot be empty.'
) LIMIT 1;


INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00006','NO','Login successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00006' AND  `Message` = 'Login successfully.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00007','NO','Signup successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00007' AND  `Message` = 'Signup successfully.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00008','YES','Invalid username/password.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00008' AND  `Message` = 'Invalid username/password.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00009','YES','Invalid language.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00009' AND  `Message` = 'Invalid language.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00010','YES','Username cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00010' AND  `Message` = 'Username cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00011','YES','Password cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00011' AND  `Message` = 'Password cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00012','YES','Language cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00012' AND  `Message` = 'Language cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00013','YES','password/confirm password not match.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00013' AND  `Message` = 'password/confirm password not match.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00014','YES','Plan ID cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00014' AND  `Message` = 'Plan ID cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00015','YES','First Name cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00015' AND  `Message` = 'First Name cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00016','YES','Last Name cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00016' AND  `Message` = 'Last Name cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00017','YES','Confirm Password cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00017' AND  `Message` = 'Confirm Password cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00018','YES','EMail ID cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00018' AND  `Message` = 'EMail ID cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00019','YES','Phone Number cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00019' AND  `Message` = 'Phone Number cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00020','YES','Plan ID cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00020' AND  `Message` = 'Plan ID cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00021','YES','Invalid Plan ID.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00021' AND  `Message` = 'Invalid Plan ID.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00022','YES','Source cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00022' AND  `Message` = 'Source cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00023','YES','Template cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00023' AND  `Message` = 'Template cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00024','YES','Message cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00024' AND  `Message` = 'Message cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00025','YES','Invalid Template.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00025' AND  `Message` = 'Invalid Template.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00026','YES','API Name cannot be empty.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00026' AND  `Message` = 'API Name cannot be empty.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00027','YES','Invalid API Name.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00027' AND  `Message` = 'Invalid API Name.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00028','NO','URL generation successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00028' AND  `Message` = 'URL generation successfully.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00029','NO','Template return successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00029' AND  `Message` = 'Template return successfully.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00030','NO','Message sent successfully.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00030' AND  `Message` = 'Template return successfully.'
) LIMIT 1;

INSERT INTO `messagemaster` (`Code`,`ErrorFound`, `Message`, `version`, `language`)
SELECT * FROM (SELECT 'ERR00031','YES','Unable to sent message, Please try some time.','1.0.0','English') AS tmp
WHERE NOT EXISTS (
    SELECT `Code` FROM `messagemaster` WHERE `Code` = 'ERR00031' AND  `Message` = 'Unable to sent message, Please try some time.'
) LIMIT 1;