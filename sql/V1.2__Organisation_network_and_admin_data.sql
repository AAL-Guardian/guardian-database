/**
 * Author:  moverkamp
 * Created: Jan 8, 2021
 */

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


INSERT INTO `organisation` (`id`, `name`, `description`, `is_system`, `sortorder`, `subdomain`, `allow_sign_up`, `allow_network_creation`, `has_communities`, `has_tasks`, `has_logbook`, `has_socialmap`, `has_timeline_on_dashboard`, `has_emp_dpts`, `image_id`) VALUES
	(1, 'NONE', 'Clients not related to any client group', 1, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
	(2, 'TEST', 'Clients used for testing purposes', 1, 2, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
	(3, 'DEMO', 'Clients used for demo purposes', 1, 3, 'demo', 0, 0, 0, 0, 0, 0, 0, 0, NULL),
	(100, 'ZNWV', 'Zorggroep Noord-West Veluwe', 0, 100, 'znwv', 0, 0, 0, 0, 0, 0, 0, 0, NULL),
	(101, 'CoME', 'CoME', 0, 101, 'come', 0, 0, 0, 0, 0, 0, 0, 0, NULL),
	(102, 'MedGUIDE', 'MedGUIDE', 0, 102, 'medguide', 0, 0, 0, 0, 0, 0, 0, 0, NULL),
	(103, 'PostNL', 'Het Langer Thuis Platform', 0, 103, 'hltp', 0, 1, 1, NULL, NULL, NULL, NULL, 0, NULL);


INSERT INTO `network_group` (`id`, `name`, `description`) VALUES
	(1, 'Client', 'Client'),
	(2, 'Professional', 'Professional'),
	(3, 'Informal', 'Informal');


INSERT INTO `network_relationship` (`id`, `name`, `description`, `network_group_id`) VALUES
	(1, 'Client', 'Client', 1),
	(2, 'Other', 'Other', 3),
	(3, 'Parent', 'Parent', 3),
	(4, 'Son', 'Son', 3),
	(5, 'Daughter', 'Daughter', 3),
	(6, 'Neighbour', 'Neighbour', 3),
	(7, 'Doctor', 'Doctor', 2),
	(8, 'Nurse', 'Nurse', 2),
	(9, 'Pharmacist', 'Pharmacist', 2);


INSERT INTO `network_relationship_text` (`id`, `network_relationship_id`, `language`, `text`) VALUES
	(1, 1, 'en', 'Client'),
	(2, 2, 'en', 'Other'),
	(3, 3, 'en', 'Parent'),
	(4, 4, 'en', 'Son'),
	(5, 5, 'en', 'Daughter'),
	(6, 6, 'en', 'Neighbour'),
	(7, 7, 'en', 'Doctor'),
	(8, 8, 'en', 'Nurse'),
	(9, 1, 'nl', 'Klant'),
	(10, 2, 'nl', 'Anders'),
	(11, 3, 'nl', 'Ouder'),
	(12, 4, 'nl', 'Zoon'),
	(13, 5, 'nl', 'Dochter'),
	(14, 6, 'nl', 'Buurman/vrouw'),
	(15, 7, 'nl', 'Dokter'),
	(16, 8, 'nl', 'Verpleger/ster'),
	(17, 9, 'en', 'Pharmacist'),
	(18, 9, 'nl', 'Apotheker'),
	(19, 1, 'no', 'Bruker'),
	(20, 2, 'no', 'Annen'),
	(21, 3, 'no', 'Forelder'),
	(22, 4, 'no', 'Sønn'),
	(23, 5, 'no', 'Datter'),
	(24, 6, 'no', 'Nabo'),
	(25, 7, 'no', 'Lege'),
	(26, 8, 'no', 'Sykepleier'),
	(27, 9, 'no', 'Farmasøyt'),
	(28, 1, 'el', 'Πελάτης'),
	(29, 2, 'el', 'Άλλο'),
	(30, 3, 'el', 'Γονιός'),
	(31, 4, 'el', 'Γιος'),
	(32, 5, 'el', 'Κόρη'),
	(33, 6, 'el', 'Γείτονας'),
	(34, 7, 'el', 'Γιατρός'),
	(35, 8, 'el', 'Νοσοκόμος/α'),
	(36, 9, 'el', 'Φαρμακοποιός');


-- Create admin person
INSERT INTO `persons` (`id`, `version`, `name`, `email`, `new_email`, `date_email_changed`, `send_email_overview`, `phone`, `contactinfo`,
 `date_created`, `date_current_visit`, `date_email_overview_sent`, `date_modified`, `date_no_image_mail_send`, `role`, `externalid`,
 `date_deleted`, `date_last_visit`, `language`, `initials`, `call_url`, `birth_day`, `google_calendar_id`, `google_sync_option`,
 `is_professional`, `is_saml`, `mobile_pin_code`, `is_tour_done`, `date_tour_done`, `show_help_on_startup`, `date_preauthorization`,
 `time_zone`, `old_name`, `old_email`, `send_email_engagement`, `image_id`, `send_email_chat`, `send_email_community_update`) VALUES
	('00000000-68ca-48ed-b9f6-93f8082941d5', 0, 'Admin', 'admin@example.com', NULL, NULL, 'NONE', NULL, NULL,
      NOW(), NULL, NULL, NULL, NULL, 'ADMIN', 0,
      NULL, NULL, 'en', 'AD', NULL, NULL, NULL, 'ALL_APP',
      0, 0, '00000', 1, NULL, 1, NULL,
      'Europe/Amsterdam', NULL, NULL, 0, NULL, 0, 0);

-- Create user for the admin to enable the admin to log in (with the email address as user name).
-- Note: the password is the hashed version of "Test#123"
INSERT INTO `users` (`id`, `version`, `username`, `password`,
 `person_id`, `date_notification`, `old_username`, `date_created`, `date_updated`, `date_deleted`) VALUES
	('00000000-53cb-4dc7-b706-88445838854b', 0, 'admin@example.com', '1000:1c377218d8ad27d627c8d98ad7b5e16fc4f63211c0ce2b45:76e80085eb7e4ff1a991f07dd9f19fe22f4201780d05471a',
      '00000000-68ca-48ed-b9f6-93f8082941d5', NULL, NULL, NOW(), NOW(), NULL);


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
