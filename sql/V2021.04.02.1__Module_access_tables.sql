/**
 * Author:  moverkamp
 * Created: Apr 2, 2021
 */

CREATE TABLE IF NOT EXISTS `module` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL,
  `sort_order` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_unique` (`name` ASC)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `client_module` (
  `id` VARCHAR(255) NOT NULL,
  `version` INT NOT NULL,
  `module_id` BIGINT(20) NOT NULL,
  `client_id` VARCHAR(255) NOT NULL,
  `enabled` TINYINT(1) NOT NULL DEFAULT 0,
  `date_updated` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `module_client_unique` (`module_id` ASC, `client_id` ASC),
  INDEX `client_id` (`client_id` ASC),
  CONSTRAINT `fk_client_module_module` FOREIGN KEY (`module_id`)
    REFERENCES `module` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_client_module_client` FOREIGN KEY (`client_id`)
    REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `client_module_access` (
  `id` VARCHAR(255) NOT NULL,
  `version` INT NOT NULL,
  `client_module_id` VARCHAR(255) NOT NULL,
  `client_people_id` VARCHAR(255) NOT NULL,
  `overview_allowed` TINYINT(1) NOT NULL DEFAULT 0,
  `setup_allowed` TINYINT(1) NOT NULL DEFAULT 0,
  `notifications_on` TINYINT(1) NOT NULL DEFAULT 0,
  `date_updated` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `client_module_people_unique` (`client_module_id` ASC, `client_people_id` ASC),
  INDEX `client_people_id` (`client_people_id` ASC),
  CONSTRAINT `fk_client_module_access_client_module` FOREIGN KEY (`client_module_id`)
    REFERENCES `client_module` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_client_module_access_client_people` FOREIGN KEY (`client_people_id`)
    REFERENCES `client_people` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;
