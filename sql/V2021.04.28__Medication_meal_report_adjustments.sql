/**
 * Adjustments to use the report tables for medication/meal reminders, too.
 * Author:  moverkamp
 * Created: Apr 28, 2021
 */
 
-- New report types with questions and options.
INSERT INTO `report_type` (`id`, `name`, `description`, `sort_order`, `module_id`) VALUES
  (3, 'MEDICATION', 'Medication (self)reports', 3, 1),
  (4, 'MEAL', 'Meal (self)reports', 4, 2);

INSERT INTO `report_question` (`id`, `report_type_id`, `name`, `description`, `sort_order`, `multiple_answers`) VALUES
  (5, 3, 'TOOK_MEDICATION', 'Whether the medication was taken by the senior.', 1, 0),
  (6, 4, 'HAD_MEAL', 'Whether the senior had their meal.', 1, 0);

INSERT INTO `report_question_option` (`id`, `report_question_id`, `name`, `description`, `sort_order`) VALUES
  (27, 5, 'NO', 'Did not take medication', 1),
  (28, 5, 'YES', 'Did take medication', 2),
  (29, 6, 'NO', 'Did not have a meal', 1),
  (30, 6, 'YES', 'Did have a meal', 2);


-- New fields to support extra features of medication/meal reminders and/or reports.
ALTER TABLE `report_request_schedule`
  ADD COLUMN `priority` VARCHAR(10) NOT NULL DEFAULT 'NONE' COMMENT 'Enum: NONE, LOW, MEDIUM, HIGH',
  ADD COLUMN `description` VARCHAR(255) NULL COMMENT 'E.g. for medication name(s)',
  ADD COLUMN `remind_relation` VARCHAR(45) NULL COMMENT 'Whether the reminder/request should be shown before or after the event or scheduletime. Null is "at that time".',
  ADD COLUMN `remind_minutes` SMALLINT NOT NULL DEFAULT 0 COMMENT 'How many minutes before or after the event/scheduletime the reminder should be shown.',
  ADD COLUMN `remind_again_times` TINYINT NOT NULL DEFAULT 0 COMMENT 'How many times (after the first time) the reminder/request should be shown again.',
  ADD COLUMN `remind_again_minutes` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Interval between subsequent reminders.',
  ADD COLUMN `show_questions` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Show the (first) question(s), i.e. this is a report request schedule. Set to 0 to only show a reminder.';


ALTER TABLE `report_request`
  ADD COLUMN `priority` VARCHAR(10) NOT NULL DEFAULT 'NONE' COMMENT 'Enum: NONE, LOW, MEDIUM, HIGH',
  ADD COLUMN `description` VARCHAR(255) NULL COMMENT 'E.g. for medication name(s)',
  ADD COLUMN `remind_again_times` TINYINT NOT NULL DEFAULT 0 COMMENT 'How many times (after the first time) the reminder/request should be shown again.',
  ADD COLUMN `remind_again_minutes` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Interval between subsequent reminders.',
  ADD COLUMN `remind_later` TINYINT(1) NULL COMMENT 'When set to true, the senior will be reminded again, if false reminders stop.',
  ADD COLUMN `reminder_shown_times` TINYINT NOT NULL DEFAULT 0 COMMENT 'How often (after the first time) has the reminder/request been shown.',
  ADD COLUMN `date_last_shown` DATETIME NULL COMMENT 'The last time that a repeat reminder/request has been shown.',
  ADD COLUMN `show_questions` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Show the (first) question(s), i.e. this is a report request. Set to 0 to only show a reminder.';
