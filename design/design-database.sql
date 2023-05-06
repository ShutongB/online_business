-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customer_id` INT UNSIGNED NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `email_address` VARCHAR(60) NOT NULL,
  `current_address` VARCHAR(60) NOT NULL,
  `adress` VARCHAR(50) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(35) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  `begin_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `current_address` VARCHAR(45) NOT NULL,
  `zipcode` CHAR(5) NULL DEFAULT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item` (
  `item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_name` VARCHAR(45) NOT NULL,
  `net_price` DECIMAL(5,2) NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`item_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`item_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_category` (
  `item_id` INT UNSIGNED NOT NULL,
  `category_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`item_id`, `category_id`),
  INDEX `fk_item_has_category_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_item_has_category_item1_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `mydb`.`category` (`category_id`),
  CONSTRAINT `fk_item_has_category_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`item` (`item_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `order_id` INT UNSIGNED NOT NULL,
  `order_date` DATE NOT NULL,
  `order_status` ENUM('ordered', 'read_to_ship', 'shipped', 'delieved') NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_customer2_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item_has_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_has_order` (
  `item_id` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`item_id`, `order_id`),
  INDEX `fk_item_has_order_order1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_item_has_order_item1_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_has_order_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`item` (`item_id`),
  CONSTRAINT `fk_item_has_order_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`promotion` (
  `promotion_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `promo_code` CHAR(1) NOT NULL,
  `promo_amount` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`promotion_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`price`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`price` (
  `price_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sell_price` DECIMAL(5,2) NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `promotion_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`price_id`, `order_id`, `promotion_id`),
  INDEX `fk_price_order1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_price_promotion1_idx` (`promotion_id` ASC) VISIBLE,
  CONSTRAINT `fk_price_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`order_id`),
  CONSTRAINT `fk_price_promotion1`
    FOREIGN KEY (`promotion_id`)
    REFERENCES `mydb`.`promotion` (`promotion_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`item_price`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_price` (
  `price_id` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `promotion_id` INT UNSIGNED NOT NULL,
  `item_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`price_id`, `order_id`, `promotion_id`, `item_id`),
  INDEX `fk_price_has_item_item1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_price_has_item_price1_idx` (`price_id` ASC, `order_id` ASC, `promotion_id` ASC) VISIBLE,
  CONSTRAINT `fk_price_has_item_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`item` (`item_id`),
  CONSTRAINT `fk_price_has_item_price1`
    FOREIGN KEY (`price_id` , `order_id` , `promotion_id`)
    REFERENCES `mydb`.`price` (`price_id` , `order_id` , `promotion_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`item_promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_promotion` (
  `promotion_id` INT UNSIGNED NOT NULL,
  `item_id` INT UNSIGNED NOT NULL,
  INDEX `fk_item_promotion_promotion1_idx` (`promotion_id` ASC) VISIBLE,
  INDEX `fk_item_promotion_item1_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_promotion_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`item` (`item_id`),
  CONSTRAINT `fk_item_promotion_promotion1`
    FOREIGN KEY (`promotion_id`)
    REFERENCES `mydb`.`promotion` (`promotion_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payment` (
  `payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice` DECIMAL(5,2) NOT NULL,
  `payment_method` ENUM('PayPal', 'Venmo', 'Debit card', 'Credit card', 'Cash', 'Check', 'Other') NOT NULL,
  `payment_date` DATE NOT NULL,
  `amount_paid` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`order_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_payment` (
  `payment_id` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`payment_id`, `order_id`),
  INDEX `fk_order_has_payment_payment1_idx` (`payment_id` ASC) VISIBLE,
  INDEX `fk_order_payment_order1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_has_payment_payment1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `mydb`.`payment` (`payment_id`),
  CONSTRAINT `fk_order_payment_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shipping` (
  `shipping_id` INT UNSIGNED NOT NULL,
  `tracking_num` INT NOT NULL,
  `shipping_status` ENUM('ready for ship', 'shipped', 'delivered') NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`shipping_id`, `order_id`),
  INDEX `fk_shipping_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_shipping_order1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_shipping_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`),
  CONSTRAINT `fk_shipping_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customer_id` INT UNSIGNED NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `email_address` VARCHAR(60) NOT NULL,
  `current_address` VARCHAR(60) NOT NULL,
  `adress` VARCHAR(50) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `order_id` INT UNSIGNED NOT NULL,
  `order_date` DATE NOT NULL,
  `order_status` ENUM('ordered', 'read_to_ship', 'shipped', 'delieved') NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_customer2_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
