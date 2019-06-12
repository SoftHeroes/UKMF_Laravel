INSERT INTO `SMSAPISetups` (`APIName`,`server`,`resource`,`environment`,`method`,`userID`,`password`,`accessCode`,`param1`,`value1`,`param2`,`value2`,`param3`,`value3`,`param4`,`value4`,`param5`,`value5`,`param6`,`value6`,`param7`,`value7`,`receiverTag`,`messageTag`)
SELECT * FROM (SELECT 'bulksmsplans','https://www.bulksmsplans.com/','Restapis/send_sms?','local','GET',null as `userID`,null as `password`,null as `accessCode`,'api_key' as `param1`,'shubhamjobanputra@gmail.com' as `value1`,'api_token' as `param2`,'609bde2a725d506510d77579fcbcf5d31559986496' as `value2`,'sender' as `param3`,'DEMOOS' as `value3`,'msgtype' as `param4`,'1' as `value4`,null as `param5`,null as `value5`,null as `param6`,null as `value6`,null as `param7`,null as `value7`,'receiver' as `receiverTag`,'sms' as `messageTag` ) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM `SMSAPISetups` WHERE `APIName` = 'bulksmsplans' AND `environment` = 'local'
) LIMIT 1;
