/**
 * Author:  moverkamp
 * Created: Apr 20, 2021
 */

CREATE TABLE IF NOT EXISTS `pattern_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL,
  `sort_order` INT NOT NULL,
  `parent_id` BIGINT(20) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_unique` (`name` ASC),
  INDEX `parent_id` (`parent_id` ASC),
  CONSTRAINT `fk_pattern_category_pattern_category` FOREIGN KEY (`parent_id`)
    REFERENCES `pattern_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `pattern` (
  `id` VARCHAR(255) NOT NULL,
  `version` INT NOT NULL,
  `client_id` VARCHAR(255) NOT NULL,
  `pattern_category_id` BIGINT(20) NOT NULL,
  `starttime` TIME NOT NULL,
  `endtime` TIME NOT NULL,
  `frequency` VARCHAR(10) NOT NULL COMMENT 'ENUM: NONE, DAY, WEEK etc',
  `weekdays` VARCHAR(8) NULL COMMENT 'Empty when not used. Contains a number for each applicable weekday, where 1 = Monday and 7 = Sunday',
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  `date_created` DATETIME NOT NULL,
  `date_updated` DATETIME NULL,
  `date_deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `client_id` (`client_id` ASC),
  INDEX `pattern_category_id` (`pattern_category_id` ASC),
  CONSTRAINT `fk_pattern_client` FOREIGN KEY (`client_id`)
    REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pattern_pattern_category` FOREIGN KEY (`pattern_category_id`)
    REFERENCES `pattern_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


-- Add category data
INSERT INTO `pattern_category` (`id`, `name`, `description`, `sort_order`, `parent_id`) VALUES
  (1, 'SLEEP', 'Main category', 1, null),
  (2, 'REST', 'Main category', 2, null),
  (3, 'MEAL', 'Main category', 3, null),
  (4, 'BREAKFAST', 'MEAL subcategory', 1, 3),
  (5, 'LUNCH', 'MEAL subcategory', 2, 3),
  (6, 'DINNER', 'MEAL subcategory', 3, 3),
  (7, 'FRUIT', 'MEAL subcategory', 4, 3),
  (8, 'SNACK1', 'MEAL subcategory', 5, 3),
  (9, 'SNACK2', 'MEAL subcategory', 6, 3),
  (10, 'ACTIVITY', 'Main category', 4, null);
