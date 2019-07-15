DROP TABLE IF EXISTS `lookUp`;
CREATE TABLE `lookUp` (
  `code` INT(10) NOT NULL,
  `name` VARCHAR(1000) NOT NULL,
  `languageID` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
	PRIMARY KEY (`code`,`name`)
);