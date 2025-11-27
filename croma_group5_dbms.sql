-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema croma
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema croma
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `croma` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `croma` ;

-- -----------------------------------------------------
-- Table `croma`.`Stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Stores` (
  `s_id` CHAR(4) NOT NULL,
  `city` VARCHAR(15) NOT NULL,
  `region` VARCHAR(15) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `size_area` INT(4) NOT NULL,
  `emp_no` INT(3) NOT NULL,
  `p_wh` CHAR(4) NOT NULL,
  `s_wh` CHAR(4) NOT NULL,
  PRIMARY KEY (`s_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Employee` (
  `e_id` CHAR(6) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `ph` VARCHAR(10) NOT NULL,
  `email` VARCHAR(25) NOT NULL,
  `s_id` CHAR(4) NOT NULL,
  `des` VARCHAR(15) NOT NULL,
  `rep_mgr` VARCHAR(30) NOT NULL,
  `dept` VARCHAR(45) NOT NULL,
  `join_date` DATE NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `e_contact` VARCHAR(10) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `h_edu` VARCHAR(15) NULL,
  `yoe` INT(2) NOT NULL,
  `sex` ENUM('M', 'F', 'O') NOT NULL,
  `age` INT NOT NULL,
  `Stores_s_id` CHAR(4) NOT NULL,
  PRIMARY KEY (`e_id`),
  UNIQUE INDEX `ph_UNIQUE` (`ph` ASC) VISIBLE,
  UNIQUE INDEX `s_id_UNIQUE` (`s_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_Employee_Stores_idx` (`Stores_s_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Stores`
    FOREIGN KEY (`Stores_s_id`)
    REFERENCES `croma`.`Stores` (`s_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Brands` (
  `b_id` CHAR(3) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `rating` INT(1) NOT NULL,
  PRIMARY KEY (`b_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Category` (
  `c_id` CHAR(3) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `Brands_b_id` CHAR(3) NOT NULL,
  PRIMARY KEY (`c_id`, `Brands_b_id`),
  INDEX `fk_Category_Brands1_idx` (`Brands_b_id` ASC) VISIBLE,
  CONSTRAINT `fk_Category_Brands1`
    FOREIGN KEY (`Brands_b_id`)
    REFERENCES `croma`.`Brands` (`b_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Customer` (
  `cus_id` CHAR(6) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `email` VARCHAR(25) NOT NULL,
  `ph` VARCHAR(10) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `loy_stat` ENUM('y', 'n') NOT NULL,
  `age` INT(2) NOT NULL,
  `sex` ENUM('M', 'F', 'O') NOT NULL,
  `tot_pur` DECIMAL(13,2) NOT NULL,
  `pts` INT(10) NOT NULL,
  `l_pur` DATE NOT NULL,
  `Service_request_e_id` CHAR(6) NOT NULL,
  PRIMARY KEY (`cus_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `ph_UNIQUE` (`ph` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Transactions` (
  `t_id` CHAR(8) NOT NULL,
  `cus_id` CHAR(6) NOT NULL,
  `p_id` CHAR(8) NOT NULL,
  `date` DATETIME NOT NULL,
  `p_mthd` ENUM('cc', 'cash', 'dc', 'online', 'chq') NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `sales_e_id` CHAR(6) NOT NULL,
  `cshr_e_id` CHAR(6) NOT NULL,
  `sale_mode` ENUM('store', 'online') NOT NULL,
  `c_rating` INT(1) NOT NULL,
  `Stores_s_id` CHAR(4) NOT NULL,
  `Customer_cust_id` CHAR(6) NOT NULL,
  PRIMARY KEY (`t_id`),
  UNIQUE INDEX `cus_id_UNIQUE` (`cus_id` ASC) VISIBLE,
  UNIQUE INDEX `p_id_UNIQUE` (`p_id` ASC) VISIBLE,
  UNIQUE INDEX `sales_e_id_UNIQUE` (`sales_e_id` ASC) VISIBLE,
  UNIQUE INDEX `cshr_e_id_UNIQUE` (`cshr_e_id` ASC) VISIBLE,
  INDEX `fk_Transactions_Stores1_idx` (`Stores_s_id` ASC) VISIBLE,
  INDEX `fk_Transactions_Customer1_idx` (`Customer_cust_id` ASC) VISIBLE,
  CONSTRAINT `fk_Transactions_Stores1`
    FOREIGN KEY (`Stores_s_id`)
    REFERENCES `croma`.`Stores` (`s_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transactions_Customer1`
    FOREIGN KEY (`Customer_cust_id`)
    REFERENCES `croma`.`Customer` (`cus_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Products` (
  `p_id` CHAR(8) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(200) NOT NULL,
  `specs` VARCHAR(45) NOT NULL,
  `c_id` CHAR(3) NOT NULL,
  `b_id` CHAR(3) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `Category_c_id` CHAR(3) NOT NULL,
  `Brands_b_id` CHAR(3) NOT NULL,
  `Stores_s_id` CHAR(4) NOT NULL,
  `Transactions_t_id` CHAR(8) NOT NULL,
  PRIMARY KEY (`p_id`, `Category_c_id`, `Brands_b_id`),
  INDEX `fk_Products_Category1_idx` (`Category_c_id` ASC) VISIBLE,
  INDEX `fk_Products_Brands1_idx` (`Brands_b_id` ASC) VISIBLE,
  INDEX `fk_Products_Stores1_idx` (`Stores_s_id` ASC) VISIBLE,
  INDEX `fk_Products_Transactions1_idx` (`Transactions_t_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Category1`
    FOREIGN KEY (`Category_c_id`)
    REFERENCES `croma`.`Category` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_Brands1`
    FOREIGN KEY (`Brands_b_id`)
    REFERENCES `croma`.`Brands` (`b_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_Stores1`
    FOREIGN KEY (`Stores_s_id`)
    REFERENCES `croma`.`Stores` (`s_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_Transactions1`
    FOREIGN KEY (`Transactions_t_id`)
    REFERENCES `croma`.`Transactions` (`t_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Vendors` (
  `v_id` CHAR(8) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(15) NOT NULL,
  `region` VARCHAR(15) NOT NULL,
  `p_id` CHAR(8) NOT NULL,
  `wh_id` CHAR(3) NOT NULL,
  PRIMARY KEY (`v_id`),
  UNIQUE INDEX `p_id_UNIQUE` (`p_id` ASC) VISIBLE,
  UNIQUE INDEX `wh_id_UNIQUE` (`wh_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Purchase` (
  `pur_id` CHAR(8) NOT NULL,
  `v_id` CHAR(4) NOT NULL,
  `wh_id` CHAR(3) NOT NULL,
  `date` DATETIME NOT NULL,
  `qty` INT(5) NOT NULL,
  `amt` DECIMAL(15,2) NOT NULL,
  `pmt_stat` ENUM('paid', 'pending') NOT NULL,
  `rcv_stat` ENUM('received', 'pending') NOT NULL,
  `rcv_emp` CHAR(6) NOT NULL,
  `chk_stat` ENUM('checked', 'pending') NOT NULL,
  PRIMARY KEY (`pur_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`inventory` (
  `wh_id` CHAR(8) NOT NULL,
  `p_id` CHAR(8) NOT NULL,
  `avl_stat` ENUM('Y', 'N') NOT NULL,
  `qty` INT NOT NULL,
  PRIMARY KEY (`wh_id`),
  UNIQUE INDEX `p_id_UNIQUE` (`p_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Supply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Supply` (
  `sup_id` CHAR(8) NOT NULL,
  `p_id` CHAR(8) NOT NULL,
  `wh_id` CHAR(3) NOT NULL,
  `s_id` CHAR(4) NOT NULL,
  `date_sent` DATETIME NOT NULL,
  `date_rcv` DATETIME NOT NULL,
  `wh_e_id` CHAR(6) NOT NULL,
  `s_e_id` CHAR(6) NOT NULL,
  `inventory_wh_id` CHAR(8) NOT NULL,
  `Stores_s_id` CHAR(4) NOT NULL,
  PRIMARY KEY (`sup_id`, `inventory_wh_id`, `Stores_s_id`),
  UNIQUE INDEX `s_e_id_UNIQUE` (`s_e_id` ASC) VISIBLE,
  UNIQUE INDEX `wh_e_id_UNIQUE` (`wh_e_id` ASC) VISIBLE,
  UNIQUE INDEX `s_id_UNIQUE` (`s_id` ASC) VISIBLE,
  UNIQUE INDEX `wh_id_UNIQUE` (`wh_id` ASC) VISIBLE,
  UNIQUE INDEX `p_id_UNIQUE` (`p_id` ASC) VISIBLE,
  INDEX `fk_Supply_inventory1_idx` (`inventory_wh_id` ASC) VISIBLE,
  INDEX `fk_Supply_Stores1_idx` (`Stores_s_id` ASC) VISIBLE,
  CONSTRAINT `fk_Supply_inventory1`
    FOREIGN KEY (`inventory_wh_id`)
    REFERENCES `croma`.`inventory` (`wh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supply_Stores1`
    FOREIGN KEY (`Stores_s_id`)
    REFERENCES `croma`.`Stores` (`s_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Orders` (
  `ord_id` CHAR(8) NOT NULL,
  `cus_id` CHAR(6) NOT NULL,
  `p_id` CHAR(8) NOT NULL,
  `p_mthd` ENUM('cc', 'cash', 'dc', 'online', 'chq') NOT NULL,
  `qty` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `discount` DECIMAL(4,2) NOT NULL,
  `amt` DECIMAL(10,2) NOT NULL,
  `date` DATETIME NOT NULL,
  `stat` VARCHAR(45) NOT NULL,
  `p_stat` ENUM('pending', 'failed', 'complete') NOT NULL,
  `t_id` CHAR(8) NOT NULL,
  `Stores_s_id` CHAR(4) NOT NULL,
  `Customer_cus_id` CHAR(6) NOT NULL,
  PRIMARY KEY (`ord_id`, `Stores_s_id`, `Customer_cus_id`),
  UNIQUE INDEX `cus_id_UNIQUE` (`cus_id` ASC) VISIBLE,
  UNIQUE INDEX `p_id_UNIQUE` (`p_id` ASC) VISIBLE,
  UNIQUE INDEX `t_id_UNIQUE` (`t_id` ASC) VISIBLE,
  INDEX `fk_Orders_Stores1_idx` (`Stores_s_id` ASC) VISIBLE,
  INDEX `fk_Orders_Customer1_idx` (`Customer_cus_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Stores1`
    FOREIGN KEY (`Stores_s_id`)
    REFERENCES `croma`.`Stores` (`s_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Customer1`
    FOREIGN KEY (`Customer_cus_id`)
    REFERENCES `croma`.`Customer` (`cus_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Service_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Service_request` (
  `ser_id` CHAR(8) NOT NULL,
  `cust_id` CHAR(8) NOT NULL,
  `date` DATETIME NOT NULL,
  `p_id` CHAR(8) NOT NULL,
  `ser_type` VARCHAR(45) NOT NULL,
  `assn_e_id` CHAR(6) NOT NULL,
  `status` ENUM('Pending', 'inprocess', 'done', 'unable') NOT NULL,
  `amt` INT NOT NULL,
  `p_mthd` ENUM('cc', 'cash', 'dc', 'online', 'chq') NOT NULL,
  `p_stat` ENUM('pending', 'failed', 'complete') NOT NULL,
  `Employee_e_id` CHAR(6) NOT NULL,
  `Customer_cust_id` CHAR(6) NOT NULL,
  PRIMARY KEY (`ser_id`),
  UNIQUE INDEX `c_id_UNIQUE` (`cust_id` ASC) VISIBLE,
  UNIQUE INDEX `p_id_UNIQUE` (`p_id` ASC) VISIBLE,
  UNIQUE INDEX `assn_e_id_UNIQUE` (`assn_e_id` ASC) VISIBLE,
  INDEX `fk_Service_request_Employee1_idx` (`Employee_e_id` ASC) VISIBLE,
  INDEX `fk_Service_request_Customer1_idx` (`Customer_cust_id` ASC) VISIBLE,
  CONSTRAINT `fk_Service_request_Employee1`
    FOREIGN KEY (`Employee_e_id`)
    REFERENCES `croma`.`Employee` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Service_request_Customer1`
    FOREIGN KEY (`Customer_cust_id`)
    REFERENCES `croma`.`Customer` (`cus_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Store_has_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Store_has_customers` (
  `Customer_cust_id` CHAR(6) NOT NULL,
  `Stores_s_id` CHAR(4) NOT NULL,
  PRIMARY KEY (`Customer_cust_id`, `Stores_s_id`),
  INDEX `fk_Customer_has_Stores_Stores1_idx` (`Stores_s_id` ASC) VISIBLE,
  INDEX `fk_Customer_has_Stores_Customer1_idx` (`Customer_cust_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_has_Stores_Customer1`
    FOREIGN KEY (`Customer_cust_id`)
    REFERENCES `croma`.`Customer` (`cus_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Stores_Stores1`
    FOREIGN KEY (`Stores_s_id`)
    REFERENCES `croma`.`Stores` (`s_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`Purchase_has_Vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`Purchase_has_Vendors` (
  `Purchase_pur_id` CHAR(8) NOT NULL,
  `Vendors_v_id` CHAR(8) NOT NULL,
  PRIMARY KEY (`Purchase_pur_id`, `Vendors_v_id`),
  INDEX `fk_Purchase_has_Vendors_Vendors1_idx` (`Vendors_v_id` ASC) VISIBLE,
  INDEX `fk_Purchase_has_Vendors_Purchase1_idx` (`Purchase_pur_id` ASC) VISIBLE,
  CONSTRAINT `fk_Purchase_has_Vendors_Purchase1`
    FOREIGN KEY (`Purchase_pur_id`)
    REFERENCES `croma`.`Purchase` (`pur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Purchase_has_Vendors_Vendors1`
    FOREIGN KEY (`Vendors_v_id`)
    REFERENCES `croma`.`Vendors` (`v_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `croma`.`inventory_has_Purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `croma`.`inventory_has_Purchase` (
  `inventory_wh_id` CHAR(8) NOT NULL,
  `Purchase_pur_id` CHAR(8) NOT NULL,
  PRIMARY KEY (`inventory_wh_id`, `Purchase_pur_id`),
  INDEX `fk_inventory_has_Purchase_Purchase1_idx` (`Purchase_pur_id` ASC) VISIBLE,
  INDEX `fk_inventory_has_Purchase_inventory1_idx` (`inventory_wh_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_has_Purchase_inventory1`
    FOREIGN KEY (`inventory_wh_id`)
    REFERENCES `croma`.`inventory` (`wh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_has_Purchase_Purchase1`
    FOREIGN KEY (`Purchase_pur_id`)
    REFERENCES `croma`.`Purchase` (`pur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

#Populating the tables
insert into Stores values ('1234','Chennai','South','No 7, Kodambakkam main road, Chennai','0900','050','0234','0025');
insert into Stores values ('1294','Chennai','South','No 11, MG road, T.Nagar, Chennai','1200','095','0025','0185');

insert into Employee values ('123456','VKumar','1234567891','vkumar@croma.in','0025','Floor Manager','Kishore S.','Large Appliances','2010-11-25','0000092000','3216549871','abc house road 2, delhi','MBA','18','M','45','0025');

insert into Brands values ('224','Lenovo','5');

insert into Category values ('886','Laptop','224');

insert into Customer values ('123456','Lorem Ipsum','dolorsi@gmail.com','3216549871','abc road, house 42, mumbai','y','42','M','0000000091123.12','0000007891','2017-07-12','123456');

insert into Transactions values ('12345678','123456','12345678','2025-11-27 16:30:00','cc','000000000912345.33','123456','456123','store','5','0029','665544');

insert into Products values ('12345678','HP Pavilion 15 inch i5 1650 super 250 ssd 1 tb hdd','New release from HP with creator grade components and fast storage','i5 9300H,GTX 1650 Super,250 + 1TB','023','224','0000067891.25','023','224','0029','12345678');

insert into Vendors values ('12345678','Gulati suppliers','Market 12, delhi','Delhi','North','12345678','123');

insert into Purchase values ('12345678','0123','456','2025-10-29 16:30:00','00250','000000009112345.25','paid','pending','123456','pending');

insert into inventory values ('12345678','45678912','Y','500');

insert into Supply values ('12345678','12345678','123','1234','2024-08-18 12:40:00','2024-08-19 10:30:00','123456','456123','45678912','4567');

insert into Orders values ('12345678','123456','12345678','cc','500','0000067891.23','12.25','0000067891.25','2025-11-27 16:30:00','Complete','pending','12345678','1234','123456');

insert into Service_request values ('12345678','264780', '2025-11-27 16:30:00','784926','washing machine repair', '284067', 'inprocess', '009089.00','online','pending','264780','284067');