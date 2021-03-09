/**
 * Author:  moverkamp
 * Created: Mar 3, 2021
 */

DELETE
FROM report_type;


INSERT INTO `report_type` (`id`, `name`, `description`, `sort_order`) VALUES
  (1, 'WELLBEING', 'Mental and physical wellbeing reports', 1),
  (2, 'SLEEP', 'Sleep quality reports', 2);


INSERT INTO `report_question` (`id`, `report_type_id`, `name`, `description`, `sort_order`, `multiple_answers`) VALUES
  (1, 1, 'LEVEL', 'Wellbeing level', 1, 0),
  (2, 1, 'REASON_BAD', 'Followup: reasons for bad wellbeing level', 2, 1),
  (3, 2, 'QUALITY', 'Sleep quality', 1, 0),
  (4, 2, 'REASON_BAD', 'Followup: reasons for poor sleep quality', 2, 1);


INSERT INTO `report_question_option` (`id`, `report_question_id`, `name`, `description`, `sort_order`) VALUES
  (1, 1, 'VERY_GOOD', 'Very good wellbeing', 4),
  (2, 1, 'FAIRLY_GOOD', 'Fairly good wellbeing', 3),
  (3, 1, 'FAIRLY_BAD', 'Fairly bad wellbeing', 2),
  (4, 1, 'VERY_BAD', 'Very bad wellbeing', 1),
  (5, 2, 'PAIN', 'Bad wellbeing reason', 1),
  (6, 2, 'HEADACHE', 'Bad wellbeing reason', 2),
  (7, 2, 'NAUSEOUS', 'Bad wellbeing reason', 3),
  (8, 2, 'DIZZINESS', 'Bad wellbeing reason', 4),
  (9, 2, 'LONELINESS', 'Bad wellbeing reason', 5),
  (10, 2, 'WORRY', 'Bad wellbeing reason', 6),
  (11, 2, 'BOREDOM', 'Bad wellbeing reason', 7),
  (12, 2, 'TENSION', 'Bad wellbeing reason', 8),
  (13, 2, 'OTHER', 'Bad wellbeing reason', 9),
  (14, 3, 'VERY_GOOD', 'Very good sleep', 4),
  (15, 3, 'FAIRLY_GOOD', 'Fairly good sleep', 3),
  (16, 3, 'FAIRLY_BAD', 'Fairly bad sleep', 2),
  (17, 3, 'VERY_BAD', 'Very bad sleep', 1),
  (18, 4, 'NOT_FALL_ASLEEP_30MIN', 'Bad sleep: cannot get to sleep within 30 minutes', 1),
  (19, 4, 'WAKE_UP_EARLY', 'Bad sleep: wake up in the middle of the night or early morning', 2),
  (20, 4, 'BATHROOM', 'Bad sleep: have to get up to use the bathroom', 3),
  (21, 4, 'BREATHING', 'Bad sleep: cannot breathe comfortably', 4),
  (22, 4, 'COUGH_OR_SNORE', 'Bad sleep: cough or snore loudly', 5),
  (23, 4, 'TOO_COLD', 'Bad sleep: feel too cold', 6),
  (24, 4, 'TOO_HOT', 'Bad sleep: feel too hot', 7),
  (25, 4, 'PAIN', 'Bad sleep: have pain', 8),
  (26, 4, 'OTHER', 'Bad sleep: other', 9);


INSERT INTO `report_question_followup` (`report_question_id`, `report_question_option_id`, `followup_question_id`) VALUES
  (1, 3, 2),
  (1, 4, 2),
  (3, 16, 4),
  (3, 17, 4);

