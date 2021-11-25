/**
 * Author:  Fabrizio Marconi
 * Created: Nov 25, 2021
 */

-- Added columns for better display report request options.
ALTER TABLE `report_question_option` 
  ADD COLUMN `display_color` VARCHAR(10) NULL DEFAULT NULL AFTER `display_icon`,
  ADD COLUMN `is_yes_no` TINYINT(1) NULL DEFAULT NULL AFTER `display_color`;