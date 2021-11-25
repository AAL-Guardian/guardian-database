/**
 * Author:  moverkamp
 * Created: Apr 9, 2021
 */

ALTER TABLE `report_type`
ADD COLUMN `module_id` BIGINT(20) NULL,
ADD CONSTRAINT `fk_report_type_module` FOREIGN KEY (`module_id`)
    REFERENCES `module` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;


-- Link WELLBEING report type to matching module
UPDATE `report_type`
SET `module_id` = 3
WHERE `name` = 'WELLBEING';

-- Link SLEEP report type to matching module
UPDATE `report_type`
SET `module_id` = 4
WHERE `name` = 'SLEEP';
