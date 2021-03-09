/**
 * Author:  moverkamp
 * Created: Feb 24, 2021
 */

DROP TABLE IF EXISTS
  `report_report_option`,
  `report`,
  `report_request`,
  `report_option`;


CREATE TABLE IF NOT EXISTS `report_question` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `report_type_id` BIGINT(20) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL,
  `sort_order` SMALLINT NOT NULL,
  `multiple_answers` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `report_type_name_unique` (`report_type_id` ASC, `name` ASC),
  CONSTRAINT `fk_report_question_report_type` FOREIGN KEY (`report_type_id`)
    REFERENCES `report_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_question_option` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `report_question_id` BIGINT(20) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL,
  `sort_order` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `report_question_name_unique` (`report_question_id` ASC, `name` ASC),
  CONSTRAINT `fk_report_question_option_report_question` FOREIGN KEY (`report_question_id`)
    REFERENCES `report_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_question_followup` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `report_question_id` BIGINT(20) NOT NULL,
  `report_question_option_id` BIGINT(20) NULL
    COMMENT 'In case this answer is given, go to the indicated followup question. If NULL, always go to this followup question',
  `followup_question_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `question_option_followup_unique` (`report_question_id` ASC, `report_question_option_id` ASC, `followup_question_id` ASC),
  INDEX `followup_question_id` (`followup_question_id` ASC),
  INDEX `report_question_option_id` (`report_question_option_id` ASC),
  CONSTRAINT `fk_report_question_followup_report_question_parent` FOREIGN KEY (`report_question_id`)
    REFERENCES `report_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_question_followup_report_question_child` FOREIGN KEY (`followup_question_id`)
    REFERENCES `report_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_question_followup_report_question_option` FOREIGN KEY (`report_question_option_id`)
    REFERENCES `report_question_option` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_request_schedule` (
  `id` VARCHAR(255) NOT NULL,
  `client_id` VARCHAR(255) NOT NULL,
  `report_type_id` BIGINT(20) NOT NULL,
  `startdate` DATE NOT NULL,
  `enddate` DATE NULL,
  `on_action_relation` VARCHAR(45) NULL COMMENT 'ENUM: BEFORE, AFTER',
  `on_action_name` VARCHAR(45) NULL,
  `scheduletime` TIME NULL COMMENT 'Used when on_action fields are null',
  `frequency` VARCHAR(10) NOT NULL COMMENT 'ENUM: NONE, DAY, WEEK etc',
  `weekdays` VARCHAR(8) NULL
    COMMENT 'Empty when not used. Contains a number for each applicable weekday, where 1 = Monday and 7 = Sunday, + R for random',
  `show_followups` TINYINT(1) NOT NULL DEFAULT 0,
  `send_notifications` TINYINT(1) NOT NULL DEFAULT 0,
  `version` INT NOT NULL,
  `date_created` DATETIME NOT NULL,
  `date_updated` DATETIME NULL,
  `date_deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `client_id` (`client_id` ASC),
  INDEX `report_type_id` (`report_type_id` ASC),
  CONSTRAINT `fk_report_request_schedule_client` FOREIGN KEY (`client_id`)
    REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_request_schedule_report_type` FOREIGN KEY (`report_type_id`)
    REFERENCES `report_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_request` (
  `id` VARCHAR(255) NOT NULL,
  `client_id` VARCHAR(255) NOT NULL,
  `report_type_id` BIGINT(20) NOT NULL,
  `report_request_schedule_id` VARCHAR(255) NULL COMMENT 'Nullable to allow for ad-hoc requests.',
  `date_created` DATETIME NOT NULL,
  `date_scheduled` DATETIME NOT NULL
    COMMENT 'Time the request should be shown and acted upon (according to the schedule, or an ad-hoc time as set by the creator (person_id).',
  `date_shown` DATETIME NULL,
  `show_followups` TINYINT(1) NOT NULL DEFAULT 0,
  `person_id` VARCHAR(255) NULL COMMENT 'Person who created the request (if not based on a request schedule)',
  `version` INT NOT NULL,
  `date_updated` DATETIME NULL,
  `date_deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `report_type_id` (`report_type_id` ASC),
  INDEX `client_id` (`client_id` ASC),
  INDEX `report_request_schedule_id` (`report_request_schedule_id` ASC),
  INDEX `person_id` (`person_id` ASC),
  CONSTRAINT `fk_report_request_report_type_` FOREIGN KEY (`report_type_id`)
    REFERENCES `report_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_request_client` FOREIGN KEY (`client_id`)
    REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_request_report_request_schedule` FOREIGN KEY (`report_request_schedule_id`)
    REFERENCES `report_request_schedule` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_report_request_person` FOREIGN KEY (`person_id`)
    REFERENCES `persons` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_answer` (
  `id` VARCHAR(255) NOT NULL,
  `client_id` VARCHAR(255) NOT NULL,
  `report_type_id` BIGINT(20) NOT NULL,
  `report_request_id` VARCHAR(255) NULL COMMENT 'Optional to accomodate ad-hoc reports.',
  `date_created` DATETIME NOT NULL,
  `person_id` VARCHAR(255) NULL COMMENT 'Creator of the report (if someone reports on the client''s behalf)',
  `version` INT NOT NULL,
  `date_updated` DATETIME NULL,
  `date_deleted` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `report_type_id` (`report_type_id` ASC),
  INDEX `client_id` (`client_id` ASC),
  INDEX `report_request_id` (`report_request_id` ASC),
  INDEX `person_id` (`person_id` ASC),
  CONSTRAINT `fk_report_answer_report_type` FOREIGN KEY (`report_type_id`)
    REFERENCES `report_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_answer_client` FOREIGN KEY (`client_id`)
    REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_answer_report_request` FOREIGN KEY (`report_request_id`)
    REFERENCES `report_request` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_report_answer_person` FOREIGN KEY (`person_id`)
    REFERENCES `persons` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_answer_question` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `report_answer_id` VARCHAR(255) NOT NULL,
  `report_question_id` BIGINT(20) NOT NULL,
  `date_created` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `report_answer_question_unique` (`report_answer_id` ASC, `report_question_id` ASC),
  INDEX `report_question_id` (`report_question_id` ASC),
  CONSTRAINT `fk_report_answer_question_report_answer` FOREIGN KEY (`report_answer_id`)
    REFERENCES `report_answer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_answer_question_report_question` FOREIGN KEY (`report_question_id`)
    REFERENCES `report_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_answer_question_option` (
  `report_answer_question_id` BIGINT(20) NOT NULL,
  `report_question_option_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`report_answer_question_id`, `report_question_option_id`),
  INDEX `report_question_option_id` (`report_question_option_id` ASC),
  CONSTRAINT `fk_report_answer_question_option_report_answer_question` FOREIGN KEY (`report_answer_question_id`)
    REFERENCES `report_answer_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_answer_question_option_report_question_option` FOREIGN KEY (`report_question_option_id`)
    REFERENCES `report_question_option` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;
