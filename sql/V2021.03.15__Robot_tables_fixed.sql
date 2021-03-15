-- MySQL Workbench Synchronization
-- Generated: 2021-03-15 11:03
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Fabrizio Marconi

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `access_token` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `robot_assignment_id` INT(10) UNSIGNED NOT NULL,
  `scope` VARCHAR(45) NOT NULL,
  `token` VARCHAR(512) NOT NULL,
  `expire` TIMESTAMP NULL DEFAULT NULL,
  `valid` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1',
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `token_UNIQUE` (`token` ASC),
  INDEX `fk_access_token_robot_assignment1_idx` (`robot_assignment_id` ASC),
  CONSTRAINT `fk_access_token_robot_assignment1`
    FOREIGN KEY (`robot_assignment_id`)
    REFERENCES `robot_assignment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 76
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `guardian_event` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `robot_serial_number` VARCHAR(45) NULL DEFAULT NULL,
  `clients_id` VARCHAR(255) NULL DEFAULT NULL,
  `event_name` VARCHAR(45) NULL DEFAULT NULL,
  `event_data` TEXT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_guardian_event_robot1_idx` (`robot_serial_number` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `robot` (
  `serial_number` VARCHAR(45) NOT NULL,
  `thing_name` VARCHAR(45) NULL DEFAULT NULL,
  `topic` VARCHAR(45) NULL DEFAULT NULL,
  `extra` TEXT NULL DEFAULT NULL,
  `active` BIT(1) NOT NULL DEFAULT b'1',
  `creation_date` VARCHAR(45) NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  PRIMARY KEY (`serial_number`),
  UNIQUE INDEX `sn_UNIQUE` (`serial_number` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `robot_assignment` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `robot_serial_number` VARCHAR(45) NOT NULL,
  `clients_id` VARCHAR(255) NOT NULL,
  `isActive` BIT(1) NOT NULL DEFAULT b'1',
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_udpate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_robot_assignment_clients1_idx` (`clients_id` ASC),
  INDEX `fk_robot_assignment_robot1_idx` (`robot_serial_number` ASC),
  CONSTRAINT `fk_robot_assignment_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_robot_assignment_robot1`
    FOREIGN KEY (`robot_serial_number`)
    REFERENCES `robot` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
