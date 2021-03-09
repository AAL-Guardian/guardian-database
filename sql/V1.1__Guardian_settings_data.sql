/**
 * Author:  moverkamp
 * Created: Jan 8, 2021
 */

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Needed for DEFAULT_MAIL_SENDER_ENTRY
INSERT INTO `mail_servers` (`id`, `host`, `port`, `protocol`, `auth`, `username`, `password`) VALUES
	(1, 'localhost', 0, 'NONE', 0, NULL, NULL);


-- Needed for DEFAULT_MAIL_SENDER_ENTRY
INSERT INTO `mail_sender_entries` (`id`, `from`, `reply_to`, `mail_server_id`) VALUES
	(1, 'from@example.com', 'noreply@example.com', 1);


INSERT INTO `settings` (`id`, `version`, `setting_key`, `setting_value`, `keytype`) VALUES
	('fd40fab5-7f09-11e4-981c-12c2c68b8645', 0, 'APPLE_PUSH_CERTIFICATE', '<==your local git repo==>/push/apns-dev-cert.p12', 'DIR'),
	('1c64f560-07be-11e6-9d1a-52540004bc1e', 0, 'APPLE_PUSH_CERTIFICATE_PASSWORD', '98ikmjk#4Z', 'STRING'),
	('8f9b6d87-af9c-11e8-974a-52540004bc1e', 0, 'COME_API_BASE_URL', '', 'STRING'),
	('7d03a639-b50c-11e7-bacc-52540004bc1e', 0, 'COME_INVITATION_SECRET_KEY', '', 'STRING'),
	('8f9771c6-af9c-11e8-974a-52540004bc1e', 0, 'COME_MAIL_SECRET_KEY', '', 'STRING'),
	('7d0b6a4c-b50c-11e7-bacc-52540004bc1e', 0, 'COME_REGISTRATION_SECRET_KEY', '', 'STRING'),
	('efb2e7c1-70c4-4d60-bf36-14feddf8df5c', 0, 'DEFAULT_FRONTEND_NAME', 'Guardian', 'STRING'),
	('5ca3af1b-221e-11e8-9b6f-52540004bc1e', 0, 'DEFAULT_MAIL_SENDER_ENTRY', '1', 'INT'),
	('z69b2c62-89c3-11e4-821f-01c2c68b8642', 0, 'DEMO_SENSOR_ID', '', 'STRING'),
	('8e452d7c-88b8-11e7-99a9-52540004bc1e', 0, 'EMAIL_ASSETS_ROOT_DIR', '<== your email assets dir ==>', 'DIR'),
	('fd40fab5-7f09-11e4-981c-00c2c68b8642', 0, 'EMPTY_PROFILE_IMAGE', 'no-image.png', 'STRING'),
	('4d3632a8-07be-11e6-9d1a-52540004bc1e', 0, 'GOOGLE_PUSH_API_KEY', '', 'STRING'),
	('a2ff4238-84f1-11e8-974a-52540004bc1e', 0, 'HOSTNAME_BASE', '<== your local client app, e.g. http://localhost:9001 ==>', 'STRING'),
	('8e4b6e0f-88b8-11e7-99a9-52540004bc1e', 0, 'IMAGES_ROOT_DIR', '<== your local images upload dir ==>', 'DIR'),
	('8e3d699d-88b8-11e7-99a9-52540004bc1e', 0, 'IMAGES_URI', 'uploads/images/', 'STRING'),
	('78719ced-3c35-4319-a308-976cc6915ed1', 0, 'LARAVEL_API_HOST', '', 'STRING'),
	('e368740b-7411-4665-be00-d831e9863f6b', 0, 'LARAVEL_API_TOKEN', '', 'STRING'),
	('842b69a9-0fa9-4de3-9757-330de1b1f5bd', 0, 'LARAVEL_API_URL', 'api', 'STRING'),
	('642e0321-32b9-11ea-9d76-52540004bc1e', 0, 'LARAVEL_LAST_EMAIL_NOTIFICATION_TIMESTAMP', '2021-01-01T09:00:00.000', 'LOCAL_DATE_TIME'),
	('5a02ed89-9b26-11e4-900b-00c2c68b8642', 0, 'LOGIN_BASE_URL', '', 'STRING'),
	('b2e2f298-c09d-11e8-974a-52540004bc1e', 0, 'LOGIN_ENCRYPTION_SECRET_KEY', 'SECRET', 'STRING'),
	('b2e63e4a-c09d-11e8-974a-52540004bc1e', 0, 'LOGIN_HMAC_SECRET_KEY', 'HMACSECRET', 'STRING'),
	('429149af-ad5b-11e9-9d76-52540004bc1e', 0, 'MEDGUIDE_CLUJ_AUTH_CLIENTID', '', 'STRING'),
	('42952f0f-ad5b-11e9-9d76-52540004bc1e', 0, 'MEDGUIDE_CLUJ_AUTH_CLIENT_SECRET', '', 'STRING'),
	('42997f7e-ad5b-11e9-9d76-52540004bc1e', 0, 'MEDGUIDE_CLUJ_AUTH_SYSTEM_PASSWORD', '', 'STRING'),
	('429d56aa-ad5b-11e9-9d76-52540004bc1e', 0, 'MEDGUIDE_CLUJ_AUTH_SYSTEM_USERNAME', '', 'STRING'),
	('81e0a285-5d0e-11e8-a2b1-52540004bc1e', 0, 'MEDGUIDE_CLUJ_REST_API', '', 'STRING'),
	('81dc14da-5d0e-11e8-a2b1-52540004bc1e', 0, 'MEDGUIDE_CLUJ_SERVICES_HOST', '', 'STRING'),
	('82dc80b3-d79d-11e8-974a-52540004bc1e', 0, 'MEDGUIDE_EMAIL_ASSETS_ROOT_DIR', '<== your MedGuide email assets dir ==>', 'STRING'),
	('82e17c83-d79d-11e8-974a-52540004bc1e', 0, 'MEDGUIDE_IMAGES_ROOT_DIR', '<== your local MedGuid images dir ==>', 'STRING'),
	('82e6cd54-d79d-11e8-974a-52540004bc1e', 0, 'MEDGUIDE_IMAGES_URI', '/assets/images/', 'STRING'),
	('a029e4b4-c09c-11e8-974a-52540004bc1e', 0, 'MEDGUIDE_HOSTNAME_BASE', '<== your local Medguid app e.g. http://localhost:4200 ==>', 'STRING'),
	('2267898d-79a9-11e6-9a4c-52540004bc1e', 0, 'SALES_NOTIFICATION_EMAIL_ADDRESS', '', 'STRING'),
	('269b2c62-89c3-11e4-821f-00c2c68b8642', 0, 'SUPPORTED_LANGUAGES', 'nl;en;fr;de;it;es;hu;el;no', 'STRING'),
	('3fde9a5b-82ab-11e8-974a-52540004bc1e', 0, 'ZINTOUCH_CONNECT_USER_ID', '57', 'STRING'),
	('3fe3d4ef-82ab-11e8-974a-52540004bc1e', 0, 'ZINTOUCH_DISCONNECT_USER_ID', '63', 'STRING'),
	('3febed8f-82ab-11e8-974a-52540004bc1e', 0, 'ZINTOUCH_EVENT_USER_ID', '56', 'STRING'),
	('3ff0d002-82ab-11e8-974a-52540004bc1e', 0, 'ZINTOUCH_HEARTBEAT_USER_ID', '55', 'STRING'),
	('1098d57a-6fc0-11e8-a2b1-52540004bc1e', 0, 'ZINTOUCH_HZ_APP_BASE_URL', '<== your local client app with Zintouch ==>', 'STRING'),
	('f6fb33fa-6fbf-11e8-a2b1-52540004bc1e', 0, 'ZINTOUCH_SECRET_KEY', '', 'STRING'),
	('108db9fb-6fc0-11e8-a2b1-52540004bc1e', 0, 'ZINTOUCH_USER_KEY', '', 'STRING'),
	('1093525a-6fc0-11e8-a2b1-52540004bc1e', 0, 'ZINTOUCH_USER_NAME', '', 'STRING');


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
