/**
 * Author:  moverkamp
 * Created: Apr 30, 2021
 */

CREATE TABLE IF NOT EXISTS `report_notification_settings` (
  `id` VARCHAR(255) NOT NULL,
  `version` INT NOT NULL,
  `report_request_schedule_id` VARCHAR(255) NOT NULL,
  `type` VARCHAR(15) NOT NULL COMMENT 'Enum: NO_RESPONSE, NO_FOLLOWUP, ON_OPTION',
  `report_question_option_id` BIGINT(20) NULL COMMENT 'Only required when type is ON_OPTION.',
  `threshold` SMALLINT NOT NULL COMMENT 'When to trigger the notification.',
  `sort_order` TINYINT NOT NULL COMMENT 'Sort order for display, per report request schedule.',
  `date_created` DATETIME NOT NULL,
  `date_updated` DATETIME NULL DEFAULT NULL,
  `date_deleted` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `schedule_type_option_unique` (`report_request_schedule_id` ASC, `type` ASC, `report_question_option_id` ASC),
  INDEX `report_question_option_id` (`report_question_option_id` ASC),
  CONSTRAINT `fk_notification_settings_report_request_schedule` FOREIGN KEY (`report_request_schedule_id`)
    REFERENCES `report_request_schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_notification_settings_report_question_option` FOREIGN KEY (`report_question_option_id`)
    REFERENCES `report_question_option` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;
