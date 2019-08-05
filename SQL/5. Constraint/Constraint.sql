ALTER TABLE UserInformation 
ADD CONSTRAINT UserInformation_fk0 FOREIGN KEY (UserPolicyID) 
REFERENCES UserPolicy(uniqueID) ON DELETE NO ACTION;

ALTER TABLE Transaction 
ADD CONSTRAINT Transaction_fk0 FOREIGN KEY (CustomerID) 
REFERENCES Customer(uniqueID) ON DELETE NO ACTION;

ALTER TABLE Customer 
ADD CONSTRAINT Customer_fk0 FOREIGN KEY (PlanID) 
REFERENCES CustomerPlan(uniqueID) ON DELETE NO ACTION;

ALTER TABLE lookup
ADD CONSTRAINT FK_lookup_language FOREIGN KEY (languageID)
REFERENCES languageLookup (uniqueID) ON DELETE NO ACTION;

ALTER TABLE SMSTemplates
ADD CONSTRAINT FK_SMSTemplates_language FOREIGN KEY (language)
REFERENCES languageLookup (language) ON DELETE NO ACTION;

ALTER TABLE messageMaster
ADD CONSTRAINT FK_messageMaster_language FOREIGN KEY (language)
REFERENCES languageLookup (language) ON DELETE NO ACTION;
