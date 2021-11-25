/**
 * Author:  moverkamp
 * Created: May 28, 2021
 */

-- New category field (mainly for the category of an activity)
ALTER TABLE `report_request_schedule`
  ADD COLUMN `category` VARCHAR(100) NULL COMMENT 'Category of the schedule/report, e.g. activity category.';


ALTER TABLE `report_request`
  ADD COLUMN `category` VARCHAR(100) NULL COMMENT 'Category of the schedule/report, e.g. activity category.';
