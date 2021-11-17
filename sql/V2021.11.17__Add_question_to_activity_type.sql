/**
 * Author:  moverkamp
 * Created: Nov 17, 2021
 */

-- Add a question and answers to the activity report type so it can be used as a self-report, too.
INSERT INTO `report_question` (`id`, `report_type_id`, `name`, `description`, `sort_order`, `multiple_answers`) VALUES
  (7, 5, 'DID_ACTIVITY', 'Whether the senior performed the activity.', 1, 0);

INSERT INTO `report_question_option` (`id`, `report_question_id`, `name`, `description`, `sort_order`) VALUES
  (31, 7, 'NO', 'Did not do the activity.', 1),
  (32, 7, 'MAYBE_LATER', 'Did not do the activity at this moment, but may do so later.', 2),
  (33, 7, 'YES', 'Did do the activity.', 3);
