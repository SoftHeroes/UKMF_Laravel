SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS UserInformation;
CREATE TABLE UserInformation (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	password varbinary(255) NOT NULL,
	firstName varchar(100),
	middleName varchar(100),
	lastName varchar(100),
	emailID varchar(250) NOT NULL UNIQUE,
	phoneNumber varchar(10) NOT NULL UNIQUE,
	creationDatetime DATETIME NOT NULL,
	lastUpdateDatetime DATETIME,
	InvaildUpdateAttemptsCount INT NOT NULL DEFAULT '0',
	UserPolicyID BIGINT(20) UNSIGNED NOT NULL,
	isLock TINYINT NOT NULL DEFAULT '0',
	deletedAt DATETIME DEFAULT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS Transaction;
CREATE TABLE Transaction (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	TransactionUUID varchar(64) NOT NULL UNIQUE,
	datetime varchar(64) NOT NULL UNIQUE,
	CustomerID BIGINT(20) UNSIGNED NOT NULL UNIQUE,
	transactionType INT NOT NULL,
	Amount DECIMAL(10) NOT NULL,
	transactionCode INT NOT NULL,
	merchantID DECIMAL(10) NOT NULL,
	FeeWaived INT NOT NULL,
	WaivedFeeAmount DECIMAL(10) NOT NULL,
	TransactionDescription varchar(200) NOT NULL,
	DebitCredit varchar(200) NOT NULL,
	EffectiveDateAndime varchar(200) NOT NULL,
	PostingDateAndTime varchar(200) NOT NULL,
	PostingFlag varchar(200) NOT NULL,
	InvoiceNumber varchar(200) NOT NULL,
	PostingReference varchar(200) NOT NULL,
	PostingTransactionSource varchar(200) NOT NULL,
	ServiceResponseCode varchar(200) NOT NULL,
	ServicePostingReference varchar(200) NOT NULL,
	PhysicalSource varchar(200) NOT NULL,
	Authorization varchar(200) NOT NULL,
	ReversalTransactionID varchar(200) NOT NULL,
	SettlementDate varchar(200) NOT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS userPolicy;
CREATE TABLE userPolicy (
	uniqueID bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	policyName varchar(255) NOT NULL UNIQUE,
	userLockTime int(11) NOT NULL DEFAULT -1,
	invaildUpdateAttemptsAllowed int(11) NOT NULL DEFAULT 3,
	isLocked tinyint(4) DEFAULT 0,
	deletedAt DATETIME DEFAULT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS ActivityLog;
CREATE TABLE ActivityLog (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	service varchar(100) NOT NULL,
	method varchar(50) NOT NULL,
	errorFound varchar(50) NOT NULL,
	ResponseCode varchar(100) NOT NULL,
	responseMessage varchar(200) NOT NULL,
	version varchar(100) NOT NULL,
	source varchar(200),
	language varchar(200) ,
	requestTime DATETIME NOT NULL,
	responseTime DATETIME NOT NULL,
	timeTaken INT(10) NOT NULL,
	request varchar(5000),
	response varchar(5000),
	expectation varchar(1000),
	customerPhone varchar(10),
	customerEmailid varchar(100),
	customerUUID varchar(100),
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS ThirdPartyAPISetup;
CREATE TABLE ThirdPartyAPISetup (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	APIName varchar(255) NOT NULL UNIQUE,
	server varchar(200) NOT NULL,
	resource varchar(200) NOT NULL,
	environment varchar(200) NOT NULL,
	method varchar(200) NOT NULL,
	userID varchar(200),
	password varbinary(255),
	accessCode varbinary(255),
	param1 varchar(255),
	value1 varchar(255),
	param2 varchar(255),
	value2 varchar(255),
	param3 varchar(255),
	value3 varchar(255),
	param4 varchar(255),
	value4 varchar(255),
	param5 varchar(255),
	value5 varchar(255),
	param6 varchar(255),
	value6 varchar(255),
	param7 varchar(255),
	value7 varchar(255),
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS APISetup;
CREATE TABLE APISetup (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	serviceName varchar(100) NOT NULL UNIQUE,
	serviceType varchar(100) NOT NULL,
	resource varchar(100) NOT NULL,
	description varchar(200) NOT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS MessageMaster;
CREATE TABLE MessageMaster (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	Code varchar(100) NOT NULL,
	ErrorFound varchar(5) NOT NULL,
	Message varchar(200) NOT NULL,
	version varchar(100) NOT NULL,
	language varchar(255) NOT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS ThirdPartyAPISetupActivityLog;
CREATE TABLE ThirdPartyAPISetupActivityLog (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	serviceID INT(10) NOT NULL,
	ResponseCode varchar(200),
	ResponseMessage varchar(200),
	requestTime DATETIME NOT NULL,
	responseTime DATETIME NOT NULL,
	timeTaken FLOAT NOT NULL,
	request varchar(5000) NOT NULL,
	response varchar(5000),
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS languageLookup;
CREATE TABLE languageLookup (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	language varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	password varbinary(255) NOT NULL,
	firstName varchar(100),
	middleName varchar(100),
	lastName varchar(100),
	emailID varchar(250) NOT NULL UNIQUE,
	phoneNumber varchar(10) NOT NULL UNIQUE,
	creationDatetime DATETIME NOT NULL,
	lastUpdateDatetime DATETIME,
	InvaildUpdateAttemptsCount INT NOT NULL DEFAULT '0',
	PlanID BIGINT(20) UNSIGNED NOT NULL,
	QRCode INT(10),
	UPIQRCode varbinary(255),
	walletAmount INT(10) DEFAULT '0',
	UPIID varchar(100),
	deletedAt DATETIME DEFAULT NULL,
  UUID varchar(100) NOT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS CustomerPlan;
CREATE TABLE CustomerPlan (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	PlanName varchar(255) NOT NULL UNIQUE DEFAULT '1',
	InvaildUpdateAttemptsAllowed INT NOT NULL DEFAULT '3',
	userLockTime INT(10) NOT NULL DEFAULT '600',
	QRCodeMethods INT,
	walletAmountLimit INT(10) NOT NULL,
	deletedAt DATETIME DEFAULT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS SMSAPISetupActivityLogs;
CREATE TABLE SMSAPISetupActivityLogs (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	serviceID INT(10) NOT NULL,
	ResponseCode varchar(200),
	ResponseMessage varchar(200),
	sendTo varchar(15),
	requestTime DATETIME NOT NULL,
	responseTime DATETIME NOT NULL,
	timeTaken FLOAT NOT NULL,
	request varchar(5000) NOT NULL,
	response varchar(5000),
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS SMSAPISetups;
CREATE TABLE SMSAPISetups (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	APIName varchar(255) NOT NULL UNIQUE,
	server varchar(255) NOT NULL,
	resource varchar(255) NOT NULL,
	environment varchar(255) NOT NULL,
	method varchar(255) NOT NULL,
	userID varchar(255),
	password varbinary(255),
	accessCode varbinary(255),
	param1 varchar(255),
	value1 varchar(255),
	param2 varchar(255),
	value2 varchar(255),
	param3 varchar(255),
	value3 varchar(255),
	param4 varchar(255),
	value4 varchar(255),
	param5 varchar(255),
	value5 varchar(255),
	param6 varchar(255),
	value6 varchar(255),
	param7 varchar(255),
	value7 varchar(255),
	receiverTag varchar(255) NOT NULL,
	messageTag varchar(255) NOT NULL,
	responseStatusTag varchar(255) NOT NULL,
	responseMessageTag varchar(255) NOT NULL,
	deletedAt DATETIME DEFAULT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS APP_ENV;
CREATE TABLE APP_ENV (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	envName varchar(255) NOT NULL ,
  PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS SMSTemplates;
CREATE TABLE SMSTemplates (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	templateName varchar(255) NOT NULL ,
	message varchar(1000),
	language varchar(255) NOT NULL,
	deletedAt DATETIME DEFAULT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS urlcodemap;
CREATE TABLE urlcodemap (
	uniqueID INT(11) NOT NULL AUTO_INCREMENT,
	encoded VARCHAR(128) NOT NULL,
	decoded VARCHAR(128) NOT NULL,
	UNIQUE KEY urlcodemapUIdx1(encoded),
	PRIMARY KEY (uniqueID)  
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS loginSetup;
CREATE TABLE loginSetup (
	uniqueID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	source varchar(100),
	OTPExpiryTime INT (2),
	resendOTPAttempts INT (2),
	OTPAttempts INT (2),
	userLockTiming INT (2),
	deletedAt DATETIME DEFAULT NULL,
	PRIMARY KEY (uniqueID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

DROP TABLE IF EXISTS lookUp;
CREATE TABLE lookUp (
	code INT(10) NOT NULL,
	name VARCHAR(255) NOT NULL,
	languageID BIGINT(20) UNSIGNED NOT NULL,
	category varchar(255) NOT NULL,
	PRIMARY KEY (code,name)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;


DROP TABLE IF EXISTS userOTPLog;
CREATE TABLE userOTPLog (
  userPhoneNumber varchar(10) NOT NULL,
  OTP varchar(255) NOT NULL,
  sendTime datetime NOT NULL
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
