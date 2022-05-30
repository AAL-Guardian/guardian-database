-- column to host emotion to be displayed after answer
ALTER TABLE `report_question_option` 
ADD COLUMN `emotion` VARCHAR(45) NULL DEFAULT NULL AFTER `is_yes_no`;