USE ukmfir9u_CardMaster;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--

--
-- Drop table `admin`
--
DROP TABLE IF EXISTS admin;

--
-- Drop table `admin_privileges`
--
DROP TABLE IF EXISTS admin_privileges;

--
-- Drop table `contactdetail`
--
DROP TABLE IF EXISTS contactdetail;

--
-- Drop table `country`
--
DROP TABLE IF EXISTS country;

--
-- Drop table `credit_debit`
--
DROP TABLE IF EXISTS credit_debit;

--
-- Drop table `credit_debit-old13feb2019`
--
DROP TABLE IF EXISTS `credit_debit-old13feb2019`;

--
-- Drop table `credit_debit-old16jan2018`
--
DROP TABLE IF EXISTS `credit_debit-old16jan2018`;

--
-- Drop table `final_e_wallet`
--
DROP TABLE IF EXISTS final_e_wallet;

--
-- Drop table `final_e_wallet-17jan2019`
--
DROP TABLE IF EXISTS `final_e_wallet-17jan2019`;

--
-- Drop table `final_e_wallet-old13feb2019`
--
DROP TABLE IF EXISTS `final_e_wallet-old13feb2019`;

--
-- Drop table `final_e_wallet-old16jan2018`
--
DROP TABLE IF EXISTS `final_e_wallet-old16jan2018`;

--
-- Drop table `matrix_downline`
--
DROP TABLE IF EXISTS matrix_downline;

--
-- Drop table `matrix_downline_ref`
--
DROP TABLE IF EXISTS matrix_downline_ref;

--
-- Drop table `paymentproof`
--
DROP TABLE IF EXISTS paymentproof;

--
-- Drop table `pins`
--
DROP TABLE IF EXISTS pins;

--
-- Drop table `points_e_wallet`
--
DROP TABLE IF EXISTS points_e_wallet;

--
-- Drop table `popup`
--
DROP TABLE IF EXISTS popup;

--
-- Drop table `promo`
--
DROP TABLE IF EXISTS promo;

--
-- Drop table `rank_achiever`
--
DROP TABLE IF EXISTS rank_achiever;

--
-- Drop table `sub_admin_category`
--
DROP TABLE IF EXISTS sub_admin_category;

--
-- Drop table `sub_admin_sub_category`
--
DROP TABLE IF EXISTS sub_admin_sub_category;

--
-- Drop table `tickets`
--
DROP TABLE IF EXISTS tickets;

--
-- Drop table `user_registration`
--
DROP TABLE IF EXISTS user_registration;

--
-- Drop table `visitor`
--
DROP TABLE IF EXISTS visitor;

--
-- Drop table `withdraw_request`
--
DROP TABLE IF EXISTS withdraw_request;

--
-- Drop table `withdraw_request-19jan2019`
--
DROP TABLE IF EXISTS `withdraw_request-19jan2019`;

--
-- Set default database
--
-- USE testdbcardtestimport;

--
-- Create table `withdraw_request-19jan2019`
--
CREATE TABLE `withdraw_request-19jan2019` (
  id int(11) NOT NULL AUTO_INCREMENT,
  transaction_number varchar(100) NOT NULL,
  user_id varchar(111) NOT NULL,
  first_name varchar(1000) NOT NULL,
  last_name varchar(1000) NOT NULL,
  acc_name varchar(1000) NOT NULL,
  acc_number varchar(1000) NOT NULL,
  bank_nm varchar(1000) NOT NULL,
  branch_nm varchar(1000) NOT NULL,
  swift_code varchar(1000) NOT NULL,
  request_amount varchar(1000) NOT NULL,
  description text NOT NULL,
  status int(11) NOT NULL,
  posted_date varchar(100) NOT NULL,
  admin_remark text NOT NULL,
  admin_response_date varchar(100) NOT NULL,
  withdraw_wallet varchar(1000) NOT NULL,
  total_paid_amount varchar(1000) NOT NULL,
  transaction_charge varchar(1000) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 23,
AVG_ROW_LENGTH = 780,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create table `withdraw_request`
--
CREATE TABLE withdraw_request (
  id int(11) NOT NULL AUTO_INCREMENT,
  transaction_number varchar(100) NOT NULL,
  user_id varchar(111) NOT NULL,
  first_name varchar(1000) NOT NULL,
  last_name varchar(1000) NOT NULL,
  acc_name varchar(1000) NOT NULL,
  acc_number varchar(1000) NOT NULL,
  bank_nm varchar(1000) NOT NULL,
  branch_nm varchar(1000) NOT NULL,
  swift_code varchar(1000) NOT NULL,
  request_amount varchar(1000) NOT NULL,
  description text NOT NULL,
  status int(11) NOT NULL,
  posted_date varchar(100) NOT NULL,
  admin_remark text NOT NULL,
  admin_response_date varchar(100) NOT NULL,
  withdraw_wallet varchar(1000) NOT NULL,
  total_paid_amount varchar(1000) NOT NULL,
  transaction_charge varchar(1000) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 503,
AVG_ROW_LENGTH = 327,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create table `visitor`
--
CREATE TABLE visitor (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(100) NOT NULL,
  username varchar(1000) NOT NULL,
  fullname varchar(1000) NOT NULL,
  ipadd varchar(1000) NOT NULL,
  times timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 39463,
AVG_ROW_LENGTH = 279,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Create table `user_registration`
--
CREATE TABLE user_registration (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(110) NOT NULL,
  ref_id varchar(110) NOT NULL,
  nom_id varchar(110) NOT NULL,
  username varchar(100) NOT NULL,
  password varchar(100) NOT NULL,
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  address text NOT NULL,
  city text NOT NULL,
  state text NOT NULL,
  country text NOT NULL,
  zipcode varchar(100) NOT NULL,
  telephone varchar(100) NOT NULL,
  admin_status int(11) NOT NULL,
  user_status varchar(100) NOT NULL,
  registration_date varchar(100) NOT NULL,
  t_code varchar(255) NOT NULL,
  user_plan varchar(50) NOT NULL,
  designation varchar(200) NOT NULL,
  aboutus text NOT NULL,
  dob varchar(255) NOT NULL,
  sex varchar(255) NOT NULL,
  image text NOT NULL,
  acc_name varchar(100) NOT NULL,
  ac_no varchar(50) NOT NULL,
  bank_nm varchar(100) NOT NULL,
  branch_nm varchar(100) NOT NULL,
  swift_code varchar(50) NOT NULL,
  user_rank_name varchar(50) NOT NULL,
  ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP,
  merried_status varchar(100) NOT NULL,
  last_login_date varchar(100) NOT NULL,
  current_login_date varchar(1000) NOT NULL,
  binary_pos varchar(100) NOT NULL,
  id_card varchar(100) NOT NULL,
  id_no varchar(100) NOT NULL,
  master_account varchar(1000) NOT NULL,
  issued varchar(100) NOT NULL,
  product_type varchar(100) NOT NULL,
  issue_date date NOT NULL,
  admin_remark1 varchar(300) NOT NULL,
  nom_name varchar(100) NOT NULL,
  nom_relation varchar(100) NOT NULL,
  nom_mobile varchar(100) NOT NULL,
  nom_dob varchar(100) NOT NULL,
  bank_state varchar(100) NOT NULL,
  ben_fullname varchar(100) NOT NULL,
  ben_nric varchar(100) NOT NULL,
  device_id text NOT NULL,
  device_type varchar(255) NOT NULL,
  activation_date date NOT NULL,
  actual_rank varchar(100) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4426,
AVG_ROW_LENGTH = 466,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `user_id` on table `user_registration`
--
ALTER TABLE user_registration
ADD UNIQUE INDEX user_id (user_id);

--
-- Create index `username` on table `user_registration`
--
ALTER TABLE user_registration
ADD UNIQUE INDEX username (username);

--
-- Create table `tickets`
--
CREATE TABLE tickets (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(255) NOT NULL,
  subject varchar(255) NOT NULL,
  tasktype varchar(255) NOT NULL,
  description varchar(255) NOT NULL,
  detail_desc varchar(255) NOT NULL,
  response_email varchar(255) NOT NULL,
  priority varchar(255) NOT NULL,
  status int(11) NOT NULL DEFAULT 0,
  t_date date NOT NULL,
  c_t_date date NOT NULL,
  response varchar(255) NOT NULL,
  user_name varchar(100) NOT NULL,
  ticket_no varchar(1000) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM,
AUTO_INCREMENT = 16,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_general_ci;

--
-- Create table `sub_admin_sub_category`
--
CREATE TABLE sub_admin_sub_category (
  id int(11) NOT NULL AUTO_INCREMENT,
  cat_id varchar(1000) NOT NULL,
  sub_cat_name varchar(1000) NOT NULL,
  link varchar(1000) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 39,
AVG_ROW_LENGTH = 630,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `sub_admin_category`
--
CREATE TABLE sub_admin_category (
  id int(11) NOT NULL AUTO_INCREMENT,
  cat_name varchar(1000) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 12,
AVG_ROW_LENGTH = 1489,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `rank_achiever`
--
CREATE TABLE rank_achiever (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(100) NOT NULL,
  from_rank varchar(100) NOT NULL,
  to_rank varchar(100) NOT NULL,
  posted_date date NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM,
AUTO_INCREMENT = 269897,
AVG_ROW_LENGTH = 47,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci;

--
-- Create table `promo`
--
CREATE TABLE promo (
  news_name varchar(255) NOT NULL,
  n_id int(100) NOT NULL AUTO_INCREMENT,
  description longtext NOT NULL,
  n_date date NOT NULL,
  status int(3) NOT NULL DEFAULT 1,
  read_viewer int(2) NOT NULL DEFAULT 1,
  posted_date varchar(1000) NOT NULL,
  PRIMARY KEY (n_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 8,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Create table `popup`
--
CREATE TABLE popup (
  id int(11) NOT NULL AUTO_INCREMENT,
  status int(11) NOT NULL,
  date date NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 2,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `points_e_wallet`
--
CREATE TABLE points_e_wallet (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(200) NOT NULL,
  amount double NOT NULL,
  status int(10) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4089,
AVG_ROW_LENGTH = 66,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `user_id` on table `points_e_wallet`
--
ALTER TABLE points_e_wallet
ADD UNIQUE INDEX user_id (user_id);

--
-- Create table `pins`
--
CREATE TABLE pins (
  id int(11) NOT NULL AUTO_INCREMENT,
  pin_no varchar(255) NOT NULL DEFAULT '',
  amount double NOT NULL,
  status tinyint(1) NOT NULL,
  crt_date date NOT NULL DEFAULT '0000-00-00',
  created_by_user varchar(200) NOT NULL,
  receiver_id varchar(255) NOT NULL,
  sender_id varchar(255) NOT NULL,
  t_date date NOT NULL,
  used_by varchar(20) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM,
AUTO_INCREMENT = 32,
AVG_ROW_LENGTH = 82,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_general_ci;

--
-- Create table `paymentproof`
--
CREATE TABLE paymentproof (
  id int(11) NOT NULL AUTO_INCREMENT,
  user varchar(100) NOT NULL,
  bank varchar(100) NOT NULL,
  amount varchar(100) NOT NULL,
  tranno varchar(100) NOT NULL,
  paymentproof varchar(100) NOT NULL,
  posteddate date NOT NULL,
  status varchar(10) NOT NULL,
  buy_rate_user varchar(255) NOT NULL,
  payment_mode varchar(255) NOT NULL,
  buy_rate_admin varchar(255) NOT NULL,
  admin_approval_date date NOT NULL,
  lifejacketid varchar(100) NOT NULL,
  final_point_alloted_on_approval varchar(100) NOT NULL,
  fourfive_days_matured varchar(10) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM,
AUTO_INCREMENT = 1001,
AVG_ROW_LENGTH = 132,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci;

--
-- Create table `matrix_downline_ref`
--
CREATE TABLE matrix_downline_ref (
  id int(11) NOT NULL AUTO_INCREMENT,
  down_id varchar(222) NOT NULL,
  income_id varchar(222) NOT NULL,
  level varchar(222) NOT NULL,
  l_date date NOT NULL,
  status int(11) NOT NULL,
  com_status int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 26859,
AVG_ROW_LENGTH = 97,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `matrix_downline`
--
CREATE TABLE matrix_downline (
  id int(11) NOT NULL AUTO_INCREMENT,
  down_id varchar(222) NOT NULL,
  income_id varchar(222) NOT NULL,
  level varchar(222) NOT NULL,
  l_date date NOT NULL,
  status int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 5972745,
AVG_ROW_LENGTH = 75,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `final_e_wallet-old16jan2018`
--
CREATE TABLE `final_e_wallet-old16jan2018` (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(200) NOT NULL,
  amount double NOT NULL,
  status int(10) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 1734,
AVG_ROW_LENGTH = 91,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `user_id` on table `final_e_wallet-old16jan2018`
--
ALTER TABLE `final_e_wallet-old16jan2018`
ADD UNIQUE INDEX user_id (user_id);

--
-- Create table `final_e_wallet-old13feb2019`
--
CREATE TABLE `final_e_wallet-old13feb2019` (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(200) NOT NULL,
  amount double NOT NULL,
  status int(10) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3648,
AVG_ROW_LENGTH = 65,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `user_id` on table `final_e_wallet-old13feb2019`
--
ALTER TABLE `final_e_wallet-old13feb2019`
ADD UNIQUE INDEX user_id (user_id);

--
-- Create table `final_e_wallet-17jan2019`
--
CREATE TABLE `final_e_wallet-17jan2019` (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(200) NOT NULL,
  amount double NOT NULL,
  status int(10) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 1847,
AVG_ROW_LENGTH = 82,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `user_id` on table `final_e_wallet-17jan2019`
--
ALTER TABLE `final_e_wallet-17jan2019`
ADD UNIQUE INDEX user_id (user_id);

--
-- Create table `final_e_wallet`
--
CREATE TABLE final_e_wallet (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id varchar(200) NOT NULL,
  amount double NOT NULL,
  status int(10) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4108,
AVG_ROW_LENGTH = 66,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `user_id` on table `final_e_wallet`
--
ALTER TABLE final_e_wallet
ADD UNIQUE INDEX user_id (user_id);

--
-- Create table `credit_debit-old16jan2018`
--
CREATE TABLE `credit_debit-old16jan2018` (
  id int(11) NOT NULL AUTO_INCREMENT,
  transaction_no varchar(1000) NOT NULL,
  user_id varchar(1000) NOT NULL,
  credit_amt varchar(1000) NOT NULL,
  debit_amt varchar(1000) NOT NULL,
  admin_charge varchar(1000) NOT NULL,
  receiver_id varchar(1000) NOT NULL,
  sender_id varchar(1000) NOT NULL,
  receive_date varchar(1000) NOT NULL,
  ttype varchar(255) NOT NULL,
  TranDescription varchar(1000) NOT NULL,
  Cause varchar(1000) NOT NULL,
  Remark varchar(1000) NOT NULL,
  invoice_no varchar(1000) NOT NULL,
  product_name varchar(1000) NOT NULL,
  status varchar(1000) NOT NULL,
  ewallet_used_by varchar(1000) NOT NULL,
  ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP (),
  current_url varchar(1000) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 268241,
AVG_ROW_LENGTH = 399,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Create table `credit_debit-old13feb2019`
--
CREATE TABLE `credit_debit-old13feb2019` (
  id int(11) NOT NULL AUTO_INCREMENT,
  transaction_no varchar(1000) NOT NULL,
  user_id varchar(1000) NOT NULL,
  credit_amt varchar(1000) NOT NULL,
  debit_amt varchar(1000) NOT NULL,
  admin_charge varchar(1000) NOT NULL,
  receiver_id varchar(1000) NOT NULL,
  sender_id varchar(1000) NOT NULL,
  receive_date varchar(1000) NOT NULL,
  ttype varchar(255) NOT NULL,
  TranDescription varchar(1000) NOT NULL,
  Cause varchar(1000) NOT NULL,
  Remark varchar(1000) NOT NULL,
  invoice_no varchar(1000) NOT NULL,
  product_name varchar(1000) NOT NULL,
  status varchar(1000) NOT NULL,
  ewallet_used_by varchar(1000) NOT NULL,
  ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP (),
  current_url varchar(1000) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 274025,
AVG_ROW_LENGTH = 267,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Create table `credit_debit`
--
CREATE TABLE credit_debit (
  id int(11) NOT NULL AUTO_INCREMENT,
  transaction_no varchar(1000) NOT NULL,
  user_id varchar(1000) NOT NULL,
  credit_amt varchar(1000) NOT NULL,
  debit_amt varchar(1000) NOT NULL,
  admin_charge varchar(1000) NOT NULL,
  receiver_id varchar(1000) NOT NULL,
  sender_id varchar(1000) NOT NULL,
  receive_date varchar(1000) NOT NULL,
  ttype varchar(255) NOT NULL,
  TranDescription varchar(1000) NOT NULL,
  Cause varchar(1000) NOT NULL,
  Remark varchar(1000) NOT NULL,
  invoice_no varchar(1000) NOT NULL,
  product_name varchar(1000) NOT NULL,
  status varchar(1000) NOT NULL,
  ewallet_used_by varchar(1000) NOT NULL,
  ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP (),
  current_url varchar(1000) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 280896,
AVG_ROW_LENGTH = 296,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Create table `country`
--
CREATE TABLE country (
  id int(11) NOT NULL AUTO_INCREMENT,
  iso char(2) NOT NULL,
  name varchar(80) NOT NULL,
  nicename varchar(80) NOT NULL,
  iso3 char(3) DEFAULT NULL,
  numcode smallint(6) DEFAULT NULL,
  phonecode int(5) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM,
AUTO_INCREMENT = 240,
AVG_ROW_LENGTH = 44,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci;

--
-- Create table `contactdetail`
--
CREATE TABLE contactdetail (
  id int(11) NOT NULL AUTO_INCREMENT,
  page_name varchar(2000) NOT NULL,
  description text NOT NULL,
  posted_date varchar(100) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 18,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create table `admin_privileges`
--
CREATE TABLE admin_privileges (
  privilege_id int(11) NOT NULL AUTO_INCREMENT,
  privilege_page varchar(100) NOT NULL,
  date date NOT NULL,
  add_date_time datetime NOT NULL,
  last_modify timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP (),
  status int(2) NOT NULL,
  admin_id bigint(20) NOT NULL,
  PRIMARY KEY (privilege_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 226,
AVG_ROW_LENGTH = 399,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `privilege_page` on table `admin_privileges`
--
ALTER TABLE admin_privileges
ADD INDEX privilege_page (privilege_page, admin_id);

--
-- Create table `admin`
--
CREATE TABLE admin (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id bigint(20) NOT NULL,
  username varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  name varchar(150) NOT NULL,
  image varchar(255) NOT NULL,
  type varchar(50) NOT NULL,
  date date NOT NULL,
  add_date_time datetime NOT NULL,
  last_modify timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP (),
  stutus int(2) NOT NULL,
  last_login datetime NOT NULL,
  last_logout datetime NOT NULL,
  login_status int(2) NOT NULL,
  website_logo varchar(10000) NOT NULL,
  transaction_pwd varchar(200) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 9,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `username` on table `admin`
--
ALTER TABLE admin
ADD UNIQUE INDEX username (username);