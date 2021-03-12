-- MySQL Workbench Synchronization
-- Generated: 2021-03-11 11:01
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Fabrizio Marconi

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `access_token` 
DROP COLUMN `robot_code`,
ADD COLUMN `robot_assignment_id` INT(10) UNSIGNED NOT NULL AFTER `id`,
ADD COLUMN `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `creation_date`,
ADD INDEX `fk_access_token_robot_assignment1_idx` (`robot_assignment_id` ASC);
;

ALTER TABLE `robot` 
ADD COLUMN `thing_name` VARCHAR(45) NULL DEFAULT NULL AFTER `serial_number`,
ADD COLUMN `extra` TEXT NULL DEFAULT NULL AFTER `topic`,
ADD COLUMN `active` BIT(1) NOT NULL DEFAULT 1 AFTER `extra`,
CHANGE COLUMN `sn` `serial_number` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `topic` `topic` VARCHAR(45) NULL DEFAULT NULL ,
ADD UNIQUE INDEX `sn_UNIQUE` (`serial_number` ASC);
;

ALTER TABLE `guardian_event` 
DROP COLUMN `robot_code`,
ADD COLUMN `robot_serial_number` VARCHAR(45) NULL DEFAULT NULL AFTER `id`,
ADD COLUMN `clients_id` VARCHAR(255) NULL DEFAULT NULL AFTER `robot_serial_number`,
ADD INDEX `fk_guardian_event_robot1_idx` (`robot_serial_number` ASC),
ADD INDEX `fk_guardian_event_clients1_idx` (`clients_id` ASC);
;

CREATE TABLE IF NOT EXISTS `robot_assignment` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `robot_serial_number` VARCHAR(45) NOT NULL,
  `clients_id` VARCHAR(255) NOT NULL,
  `isActive` BIT(1) NOT NULL DEFAULT 1,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_udpate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_robot_has_clients_clients1_idx` (`clients_id` ASC),
  INDEX `fk_robot_has_clients_robot1_idx` (`robot_serial_number` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_robot_has_clients_robot1`
    FOREIGN KEY (`robot_serial_number`)
    REFERENCES `robot` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_robot_has_clients_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `access_token` 
ADD CONSTRAINT `fk_access_token_robot_assignment1`
  FOREIGN KEY (`robot_assignment_id`)
  REFERENCES `robot_assignment` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `guardian_event` 
ADD CONSTRAINT `fk_guardian_event_robot1`
  FOREIGN KEY (`robot_serial_number`)
  REFERENCES `robot` (`serial_number`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_guardian_event_clients1`
  FOREIGN KEY (`clients_id`)
  REFERENCES `clients` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
