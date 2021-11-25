/**
 * Author:  moverkamp
 * Created: May 24, 2021
 */

-- Types of activity as pattern subcategories.
INSERT INTO `pattern_category` (`id`, `name`, `description`, `sort_order`, `parent_id`) VALUES
  (11, 'PHYSICAL_ACTIVITY', 'ACTIVITY subcategory', 1, 10),
  (12, 'SOCIAL_ACTIVITY', 'ACTIVITY subcategory', 2, 10),
  (13, 'PUZZLES', 'ACTIVITY subcategory', 3, 10),
  (14, 'GAMES', 'ACTIVITY subcategory', 4, 10),
  (15, 'GARDENING', 'ACTIVITY subcategory', 5, 10),
  (16, 'READING', 'ACTIVITY subcategory', 6, 10),
  (17, 'LISTEN_TO_MUSIC', 'ACTIVITY subcategory', 7, 10);


-- New report type for activities, to be used like a reminder (no questions defined).
INSERT INTO `report_type` (`id`, `name`, `description`, `sort_order`, `module_id`) VALUES
  (5, 'ACTIVITY', 'Activity suggestions', 5, 6);
