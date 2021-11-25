/**
 * Author:  moverkamp
 * Created: Mar 31, 2021
 */

ALTER TABLE `report_question_option`
ADD COLUMN `display_icon` VARCHAR(256) NULL;


CREATE TABLE IF NOT EXISTS `translations` (
  `id` BIGINT(20) NOT NULL NOT NULL AUTO_INCREMENT,
  `table_name` VARCHAR(64) NOT NULL,
  `column_name` VARCHAR(64) NOT NULL,
  `item_id` BIGINT(20) NOT NULL,
  `language` VARCHAR(10) NOT NULL,
  `translation` VARCHAR(512) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tab_col_item_lang_unique` (`table_name` ASC, `column_name` ASC, `item_id` ASC, `language` ASC)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;
