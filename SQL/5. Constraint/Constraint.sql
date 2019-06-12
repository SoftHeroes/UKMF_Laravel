ALTER TABLE `UserInformation` ADD CONSTRAINT `UserInformation_fk0` FOREIGN KEY (`UserPolicyID`) REFERENCES `UserPolicy`(`u_ID`);

ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_fk0` FOREIGN KEY (`CustomerID`) REFERENCES `Customer`(`u_ID`);

ALTER TABLE `ActivityLog` ADD CONSTRAINT `ActivityLog_fk0` FOREIGN KEY (`service`) REFERENCES `APISetup`(`serviceName`);

ALTER TABLE `ActivityLog` ADD CONSTRAINT `ActivityLog_fk1` FOREIGN KEY (`ResponseCode`) REFERENCES `MessageMaster`(`Code`);

ALTER TABLE `ActivityLog` ADD CONSTRAINT `ActivityLog_fk2` FOREIGN KEY (`version`) REFERENCES `MessageMaster`(`version`);

ALTER TABLE `MessageMaster` ADD CONSTRAINT `MessageMaster_fk0` FOREIGN KEY (`language`) REFERENCES `languageLookup`(`language`);

ALTER TABLE `ThirdPartyAPISetupActivityLog` ADD CONSTRAINT `ThirdPartyAPISetupActivityLog_fk0` FOREIGN KEY (`serviceID`) REFERENCES `ThirdPartyAPISetup`(`u_ID`);

ALTER TABLE `Customer` ADD CONSTRAINT `Customer_fk0` FOREIGN KEY (`PlanID`) REFERENCES `CustomerPlan`(`u_ID`);

ALTER TABLE `SMSAPISetupActivityLogs` ADD CONSTRAINT `SMSAPISetupActivityLogs_fk0` FOREIGN KEY (`serviceID`) REFERENCES `SMSAPISetups`(`u_ID`);

ALTER TABLE `SMSTemplates` ADD CONSTRAINT `SMSTemplates_fk0` FOREIGN KEY (`languageID`) REFERENCES `languageLookup`(`language`);
