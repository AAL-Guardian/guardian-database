/**
 * Author:  moverkamp
 * Created: Apr 21, 2021
 */

-- Rename on_action_relation column, to make it clear this is related to the daily pattern.
-- Add a new column to refer to the pattern category.
ALTER TABLE `report_request_schedule`
  CHANGE COLUMN `on_action_relation` `pattern_relation` VARCHAR(45) NULL COMMENT 'ENUM: BEFORE, AFTER',
  ADD COLUMN `pattern_category_id` BIGINT(20) NULL AFTER `on_action_name`,
  ADD INDEX `pattern_category_id` (`pattern_category_id` ASC),
  ADD CONSTRAINT `fk_report_request_schedule_pattern_category` FOREIGN KEY (`pattern_category_id`)
    REFERENCES `pattern_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;


-- Fill pattern_category_id based on on_action_name column
UPDATE `report_request_schedule` rrs
LEFT JOIN `pattern_category` pc ON pc.`name` = rrs.`on_action_name`
SET rrs.`pattern_category_id` = IFNULL(pc.`id`, 1)
WHERE rrs.`on_action_name` IS NOT NULL;


-- Remove on_action_name column
ALTER TABLE `report_request_schedule`
  DROP COLUMN `on_action_name`;
