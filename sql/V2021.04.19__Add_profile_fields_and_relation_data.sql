/**
 * Author:  moverkamp
 * Created: Apr 19, 2021
 */

-- Note that the birth_day column is truncated (from datetime to date).
-- Loosing the time part creates some warnings during the update, those are fine.
ALTER TABLE `persons`
CHANGE COLUMN `birth_day` `birth_day` DATE DEFAULT NULL,
ADD COLUMN `gender` VARCHAR(1) DEFAULT NULL COMMENT 'ENUM: M, F, X. Empty (null) allowed',
ADD COLUMN `form_of_address` VARCHAR(150) DEFAULT NULL COMMENT 'Preferred form of address, e.g. by Misty',
ADD COLUMN `work_phone` VARCHAR(50) DEFAULT NULL,
ADD COLUMN `country` VARCHAR(2) DEFAULT NULL COMMENT 'ISO 3166-1 two-letter country code';


ALTER TABLE `clients`
ADD COLUMN `living_arrangement` VARCHAR(255) DEFAULT NULL,
ADD COLUMN `health_status` VARCHAR(255) DEFAULT NULL;


-- Add new network relationships
INSERT INTO `network_relationship` (`id`, `name`, `description`, `network_group_id`) VALUES
  (10, 'Child', 'Child', 3),
  (11, 'Grandchild', 'Grandchild', 3),
  (12, 'Friend', 'Friend', 3);

-- And some texts for the relationships
INSERT INTO `network_relationship_text` (`network_relationship_id`, `language`, `text`) VALUES
  (10, 'en', 'Child'),
  (11, 'en', 'Grandchild'),
  (12, 'en', 'Friend'),
  (10, 'nl', 'Kind'),
  (11, 'nl', 'Kleinkind'),
  (12, 'nl', 'Vriend(in)');