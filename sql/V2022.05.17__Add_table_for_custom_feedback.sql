CREATE TABLE IF NOT EXISTS `report_feedback` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_question_option_id` BIGINT(20) NOT NULL,
  `sentence` VARCHAR(512) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_report_feedback_report_question_option1_idx` (`report_question_option_id` ASC),
  CONSTRAINT `fk_report_feedback_report_question_option1` FOREIGN KEY (`report_question_option_id`) REFERENCES `report_question_option` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8