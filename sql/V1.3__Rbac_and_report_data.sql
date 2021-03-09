/**
 * Author:  moverkamp
 * Created: Jan 8, 2021
 */

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


INSERT INTO `rbac_item` (`id`, `name`, `description`, `type`, `date_created`, `date_updated`) VALUES
	(1, 'SHOW_TIMELINE', 'Shows the timeline', 'permission', NOW(), NOW()),
	(2, 'SHOW_ZINTOUCH', 'Show the zintouch Module', 'permission', NOW(), NOW());


INSERT INTO `report_type` (`id`, `name`, `description`, `sort_order`) VALUES
	(1, 'MOOD', 'Mood reports', 1),
	(2, 'PHYSICAL_DISCOMFORT', 'Physical discomfort reports', 2);


INSERT INTO `report_option` (`id`, `report_type_id`, `name`, `description`, `sort_order`) VALUES
	(1, 1, 'NOT_SO_GOOD', 'Not so good', 1),
	(2, 1, 'OKAY', 'Okay', 2),
	(3, 1, 'GOOD', 'Good', 3),
	(4, 2, 'DIZZINESS', 'Dizziness', 1),
	(5, 2, 'HEADACHE', 'Headache', 2),
	(6, 2, 'BALANCE', 'Balance', 3),
	(7, 2, 'PAIN', 'Pain', 4),
	(8, 2, 'SHORT_OF_BREATH', 'Short of breath', 5),
	(9, 2, 'THICK_ANKLES', 'Thick ankles', 6),
	(10, 2, 'FEELING_FINE', 'Feeling fine', 7);


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;