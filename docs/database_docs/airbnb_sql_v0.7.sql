-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airbnb` DEFAULT CHARACTER SET utf8 ;
USE `airbnb` ;

-- -----------------------------------------------------
-- Table `airbnb`.`bidding`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airbnb`.`bidding` ;

CREATE TABLE IF NOT EXISTS `airbnb`.`bidding` (
  `bid_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `max_bid_days` INT(11) NULL DEFAULT '4',
  `expiry_date` DATETIME NULL DEFAULT NULL,
  `host_min_amt` DOUBLE NULL DEFAULT NULL,
  `max_bid_price` DOUBLE NULL DEFAULT NULL,
  `max_bid_user_id` VARCHAR(50) NULL DEFAULT NULL,
  `property_id` VARCHAR(50) NOT NULL,
  `property_name` VARCHAR(256) NULL DEFAULT NULL,
  `bidder_name` VARCHAR(50) NULL DEFAULT NULL,
  `is_approved` INT(1) NOT NULL DEFAULT 0,		
  PRIMARY KEY (`bid_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `airbnb`.`bidding_dtl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airbnb`.`bidding_dtl` ;

CREATE TABLE IF NOT EXISTS `airbnb`.`bidding_dtl` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bid_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `bidder_id` VARCHAR(50) NULL DEFAULT NULL,
  `bid_price` DOUBLE NULL DEFAULT NULL,
  `bid_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `property_name` VARCHAR(256) NULL DEFAULT NULL,
  `property_id` VARCHAR(50) NULL DEFAULT NULL,
  `bidder_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `bid_id_idx` (`bid_id` ASC),
  CONSTRAINT `bid_id`
    FOREIGN KEY (`bid_id`)
    REFERENCES `airbnb`.`bidding` (`bid_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `airbnb`.`trip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airbnb`.`trip` ;

CREATE TABLE IF NOT EXISTS `airbnb`.`trip` (
  `trip_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(50) NOT NULL,
  `property_id` VARCHAR(50) NULL DEFAULT NULL,
  `host_id` VARCHAR(50) NOT NULL,
  `checkin_date` VARCHAR(50) NOT NULL,
  `checkout_date` VARCHAR(50) NOT NULL,
  `no_of_guests` INT(11) NOT NULL,
  `trip_status` VARCHAR(45) NULL DEFAULT 'PENDING' COMMENT 'Values : ‘ACCEPTED’, ‘REJECTED’, ‘PENDING’,’COMPLETED’',
  `trip_approved_time` DATETIME NULL DEFAULT NULL,
  `property_name` VARCHAR(256) NULL DEFAULT NULL,
  `trip_price` DOUBLE NULL DEFAULT NULL,
  `host_name` VARCHAR(100) NULL DEFAULT NULL,
  `is_reviewed` INT(1) NOT NULL DEFAULT 0,
  `rating` INT(1) NULL DEFAULT NULL,
  `review_comment` VARCHAR(256) NULL DEFAULT NULL,
  `guest_name` VARCHAR(50) NULL DEFAULT NULL,
  `host_reviewed` INT(1) NOT NULL DEFAULT 0,	
  PRIMARY KEY (`trip_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `airbnb`.`billing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airbnb`.`billing` ;

CREATE TABLE IF NOT EXISTS `airbnb`.`billing` (
  `billing_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `trip_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `bill_status` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Values : ‘CREATED’,’DELETED’',
  PRIMARY KEY (`billing_id`),
  INDEX `billing_trip_id_idx` (`trip_id` ASC),
  CONSTRAINT `billing_trip_id`
    FOREIGN KEY (`trip_id`)
    REFERENCES `airbnb`.`trip` (`trip_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Trigger `airbnb`.`bidding`
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `airbnb`.`bidding` ;
create TRIGGER `airbnb`.`bidding` AFTER INSERT on airbnb.bidding_dtl
FOR EACH ROW
	update airbnb.bidding b set b.max_bid_price = new.bid_price, b.max_bid_user_id = new.bidder_id , b.bidder_name = new.bidder_name where 
    b.max_bid_price < new.bid_price and b.property_id = new.property_id;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Table `airbnb`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airbnb`.`admin` ;

CREATE TABLE IF NOT EXISTS `airbnb`.`admin` (  `admin_table_id` int(11) NOT NULL,  `admin_id` varchar(45) DEFAULT NULL,  `first_name` varchar(45) DEFAULT NULL,  `last_name` varchar(45) DEFAULT NULL,  `address` varchar(45) DEFAULT NULL,  `city` varchar(45) DEFAULT NULL, `zip_code` int(11) DEFAULT NULL,`phone_number` int(11) DEFAULT NULL,  `email` varchar(45) DEFAULT NULL,  `password` varchar(45) DEFAULT NULL,  PRIMARY KEY (`admin_table_id`));
INSERT INTO `airbnb`.`admin` (`admin_table_id`, `admin_id`, `first_name`, `last_name`, `address`, `city`, `zip_code`, `phone_number`, `email`, `password`) VALUES ('1', '111-111-110', 'Tarshith Vishnu', 'Pernapati', '1334, The Alameda, Apt 185', 'California', '95126', '123456789', 'vishnu@gmail.com', 'tarshith');
INSERT INTO `airbnb`.`admin` (`admin_table_id`, `admin_id`, `first_name`, `last_name`, `address`, `city`, `zip_code`, `phone_number`, `email`, `password`) VALUES ('2', '111-111-111', 'Krishna', 'Rattihalli', '1334, The Alameda, Apt 185', 'California', '95126', '123456790', 'krishna@gmail.com', 'krishna');
INSERT INTO `airbnb`.`admin` (`admin_table_id`, `admin_id`, `first_name`, `last_name`, `address`, `city`, `zip_code`, `phone_number`, `email`, `password`) VALUES ('3', '111-111-112', 'Pranjal', 'Jain', '1314, The Alameda, Apt 386', 'California', '95126', '123456791', 'pranjal@gmail.com', 'pranjal');
INSERT INTO `airbnb`.`admin` (`admin_table_id`, `admin_id`, `first_name`, `last_name`, `address`, `city`, `zip_code`, `phone_number`, `email`, `password`) VALUES ('4', '111-111-113', 'Anudeep', 'Rentala', 'SJSU', 'California', '95126', '123456792', 'anudeep@gmail.com', 'anudeep');
INSERT INTO `airbnb`.`admin` (`admin_table_id`, `admin_id`, `first_name`, `last_name`, `address`, `city`, `zip_code`, `phone_number`, `email`, `password`) VALUES ('5', '111-111-114', 'Smitha', 'muthuvenkataramani', 'SJSU', 'California', '95126', '123456793', 'smitha@gmail.com', 'smitha');
INSERT INTO `airbnb`.`admin` (`admin_table_id`, `admin_id`, `first_name`, `last_name`, `address`, `city`, `zip_code`, `phone_number`, `email`, `password`) VALUES ('6', '111-111-115', 'Varsha', 'Kankariya', 'SJSU', 'California', '95126', '123456794', 'varsha@gmail.com', 'varsha');
