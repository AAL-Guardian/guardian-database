/**
 * Author:  moverkamp
 * Created: Jan 5, 2021
 */

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE TABLE IF NOT EXISTS `action_comments` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `person_id` varchar(255) NOT NULL,
  `action_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `action_id` (`action_id`),
  CONSTRAINT `fk_action_comments_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_action_comments_action` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `actions` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `date_due` datetime DEFAULT NULL,
  `date_finished` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `person_id` varchar(255) DEFAULT NULL,
  `homecare_id` varchar(255) DEFAULT NULL,
  `has_accepted` int(11) NOT NULL,
  `has_rejected` int(11) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `client` varchar(255) NOT NULL,
  `time_used` double DEFAULT NULL,
  `date_updated` datetime NOT NULL,
  `urgent` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `client` (`client`),
  KEY `person_id` (`person_id`),
  KEY `homecare_id` (`homecare_id`),
  CONSTRAINT `fk_actions_created_by` FOREIGN KEY (`created_by`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_actions_client` FOREIGN KEY (`client`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_actions_homecare_institution` FOREIGN KEY (`homecare_id`) REFERENCES `homecare_institution` (`id`),
  CONSTRAINT `fk_actions_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `activity` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `date_start` datetime NOT NULL,
  `date_finish` datetime DEFAULT NULL,
  `client_id` varchar(255) NOT NULL,
  `sensor_id` varchar(255) NOT NULL,
  `activity_category_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_category_id` (`activity_category_id`),
  KEY `sensor_id` (`sensor_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `fk_activity_category` FOREIGN KEY (`activity_category_id`) REFERENCES `activity_category` (`id`),
  CONSTRAINT `fk_activity_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_activity_sensor` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `activity_category` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `appointment_comments` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `person_id` varchar(255) NOT NULL,
  `appointment_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `fk_appointment_comments_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`),
  CONSTRAINT `fk_appointment_comments_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `appointment_external_relations` (
  `id` varchar(255) NOT NULL,
  `appointment_id` varchar(255) NOT NULL,
  `external_source_id` varchar(255) NOT NULL,
  `external_appointment_id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_appointment_unique` (`appointment_id`,`external_source_id`),
  CONSTRAINT `fk_appointment_external_relations_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `appointment_recurrence` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `date_start` datetime NOT NULL,
  `date_finish` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `appointment_id` varchar(255) NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `fk_appointment_recurrence_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `appointment_recurrence_companions` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `person_id` varchar(255) DEFAULT NULL,
  `homecare_id` varchar(255) DEFAULT NULL,
  `appointment_recurrence_id` varchar(255) NOT NULL,
  `accepted` int(11) NOT NULL,
  `rejected` int(11) NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `homecare_id` (`homecare_id`),
  KEY `appointment_recurrence_id` (`appointment_recurrence_id`),
  CONSTRAINT `fk_appointment_recurrence_companions_recurrence` FOREIGN KEY (`appointment_recurrence_id`) REFERENCES `appointment_recurrence` (`id`),
  CONSTRAINT `fk_appointment_recurrence_companions_homecare` FOREIGN KEY (`homecare_id`) REFERENCES `homecare_institution` (`id`),
  CONSTRAINT `fk_appointment_recurrence_companions_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `appointments` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `title` varchar(150) DEFAULT NULL,
  `description` text,
  `date_start` datetime NOT NULL,
  `date_finish` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `client` varchar(255) NOT NULL,
  `date_updated` datetime NOT NULL,
  `weekdays` varchar(7) DEFAULT NULL,
  `frequencytype` varchar(10) DEFAULT NULL,
  `date_recurrency_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `client` (`client`),
  CONSTRAINT `fk_appointments_created_by` FOREIGN KEY (`created_by`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_appointments_client` FOREIGN KEY (`client`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `appointments_google_events` (
  `id` varchar(255) NOT NULL,
  `appointment_id` varchar(255) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `google_event_id` varchar(255) NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `fk_appointments_google_events_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`),
  CONSTRAINT `fk_appointments_google_events_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_client_event_phases` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(255) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `trigger_id` bigint(20) NOT NULL,
  `current` int(11) NOT NULL DEFAULT '1',
  `skipped` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `person_id` (`person_id`),
  KEY `trigger_id` (`trigger_id`),
  KEY `avatar_client_event_phases_combined` (`client_id`,`person_id`,`trigger_id`),
  CONSTRAINT `fk_avatar_client_event_phases_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_avatar_client_event_phases_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_avatar_client_event_phases_trigger` FOREIGN KEY (`trigger_id`) REFERENCES `avatar_triggers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_client_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trigger_id` bigint(20) NOT NULL,
  `parameter` varchar(4096) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `person_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trigger_id` (`trigger_id`),
  KEY `client_id` (`client_id`),
  KEY `person_id` (`person_id`),
  KEY `avatar_client_events_combined` (`client_id`,`person_id`,`trigger_id`),
  CONSTRAINT `fk_avatar_client_events_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_avatar_client_events_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_avatar_client_events_trigger` FOREIGN KEY (`trigger_id`) REFERENCES `avatar_triggers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_redirect_pages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_name_unique` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_trigger_steps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trigger_id` bigint(20) NOT NULL,
  `sequence` int(11) NOT NULL DEFAULT '1',
  `button_code` varchar(255) NOT NULL DEFAULT 'OK',
  PRIMARY KEY (`id`),
  UNIQUE KEY `trigger_sequence_unique` (`trigger_id`,`sequence`),
  KEY `trigger_id` (`trigger_id`),
  CONSTRAINT `fk_avatar_trigger_steps_trigger` FOREIGN KEY (`trigger_id`) REFERENCES `avatar_triggers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_trigger_steps_redirect_pages` (
  `trigger_step_id` bigint(20) NOT NULL,
  `redirect_page_id` bigint(20) NOT NULL,
  PRIMARY KEY (`trigger_step_id`,`redirect_page_id`),
  KEY `redirect_page_id` (`redirect_page_id`),
  KEY `trigger_step_id` (`trigger_step_id`),
  CONSTRAINT `fk_avatar_trigger_steps_redirect_pages_redirect_page` FOREIGN KEY (`redirect_page_id`) REFERENCES `avatar_redirect_pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_avatar_trigger_steps_redirect_pages_trigger_step` FOREIGN KEY (`trigger_step_id`) REFERENCES `avatar_trigger_steps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_trigger_text_create_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trigger_id` int(11) DEFAULT NULL,
  `serial_number` int(11) DEFAULT NULL,
  `en` varchar(1024) DEFAULT NULL,
  `es` varchar(1024) DEFAULT NULL,
  `nl` varchar(1024) DEFAULT NULL,
  `hu` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_trigger_text_update_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trigger_id` int(11) DEFAULT NULL,
  `serial_number` int(11) DEFAULT NULL,
  `en` varchar(1024) DEFAULT NULL,
  `es` varchar(1024) DEFAULT NULL,
  `nl` varchar(1024) DEFAULT NULL,
  `hu` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_trigger_texts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trigger_step_id` bigint(20) NOT NULL,
  `language` varchar(25) NOT NULL,
  `text` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `step_language_unique` (`trigger_step_id`,`language`),
  KEY `trigger_step_id` (`trigger_step_id`),
  CONSTRAINT `fk_avatar_trigger_texts_trigger_step` FOREIGN KEY (`trigger_step_id`) REFERENCES `avatar_trigger_steps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `avatar_triggers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `is_direct_message` int(11) NOT NULL DEFAULT '1',
  `is_mail` int(11) NOT NULL DEFAULT '0',
  `in_summary` int(11) NOT NULL DEFAULT '1',
  `group_trigger_id` bigint(20) DEFAULT NULL,
  `group_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`),
  KEY `group_trigger_id` (`group_trigger_id`),
  CONSTRAINT `fk_avatar_triggers_group_trigger` FOREIGN KEY (`group_trigger_id`) REFERENCES `avatar_triggers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `chat` (
  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'UUID string',
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Chat between two or more participants';


CREATE TABLE IF NOT EXISTS `chat_message` (
  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'UUID string',
  `text` varchar(1024) NOT NULL,
  `sender_chat_participant_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `parent_message_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `image_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_chat_participant_id` (`sender_chat_participant_id`),
  KEY `parent_message_id` (`parent_message_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `fk_chat_message_image` FOREIGN KEY (`image_id`) REFERENCES `image_metadata` (`id`),
  CONSTRAINT `fk_chat_message_parent` FOREIGN KEY (`parent_message_id`) REFERENCES `chat_message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chat_message_sender` FOREIGN KEY (`sender_chat_participant_id`) REFERENCES `chat_participant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `chat_participant` (
  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'UUID string',
  `chat_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL COMMENT 'Timestamp when participant joined the chat',
  `date_updated` datetime NOT NULL COMMENT 'Timestamp when participant last sent a message',
  `date_deleted` datetime DEFAULT NULL COMMENT 'Timestamp when participant deleted a chat (for himself)',
  `last_message_read_on` datetime DEFAULT NULL COMMENT 'Timestamp when participant last read messages from this chat',
  `last_chat_notification` datetime DEFAULT NULL COMMENT 'Timestamp when a unread-chat-messages email notification was last sent to a person. This column is reset when a person reads messages using the API.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chat_participant_unique` (`chat_id`,`person_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `fk_chat_participant_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chat_participant_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Chat participant (participant can delete his side of chat) and that makes chat unavailable to that person.';


CREATE TABLE IF NOT EXISTS `client_mail_sender_entry` (
  `client_id` varchar(255) NOT NULL,
  `mail_sender_entry_id` bigint(20) NOT NULL,
  PRIMARY KEY (`client_id`,`mail_sender_entry_id`),
  KEY `mail_sender_entry_id` (`mail_sender_entry_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `fk_client_mail_sender_entry_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_client_mail_sender_entry_mail_sender_entry` FOREIGN KEY (`mail_sender_entry_id`) REFERENCES `mail_sender_entries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `client_people` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `network_relationship_id` bigint(20) DEFAULT NULL,
  `networkRole` varchar(25) NOT NULL DEFAULT 'CLOSECAREGIVER',
  `networkAdmin` int(11) NOT NULL DEFAULT '0',
  `perceived_care_load` int(11) DEFAULT NULL,
  `helps_with` varchar(512) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `accepted` int(11) NOT NULL,
  `rejected` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `date_last_visit` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_person_unique` (`client_id`,`person_id`),
  KEY `network_relationship_id` (`network_relationship_id`),
  KEY `person_id` (`person_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `fk_client_people_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_client_people_network_relationship` FOREIGN KEY (`network_relationship_id`) REFERENCES `network_relationship` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_client_people_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `clients` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `directId` varchar(255) DEFAULT NULL,
  `provider` varchar(25) NOT NULL DEFAULT 'DEFAULT',
  `showSensorHistory` int(11) NOT NULL DEFAULT '0',
  `isTestClient` int(11) NOT NULL DEFAULT '0',
  `hiddenDescription` varchar(150) DEFAULT '',
  `log` int(11) NOT NULL DEFAULT '0',
  `organisation_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `date_last_visit` datetime DEFAULT NULL,
  `show_demo_sensors` int(11) NOT NULL DEFAULT '0',
  `NHG_link_needed` int(11) NOT NULL DEFAULT '0',
  `has_medguide_medido` int(11) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `fk_clients_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `fk_clients_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_clients_organisation` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `community` (
  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'UUID string',
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `organisation_id` bigint(20) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `image_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `show_external_services` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Flag that determines if external services are shown.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `organisation_name_unique` (`organisation_id`,`name`),
  KEY `organisation_id` (`organisation_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `fk_community_image` FOREIGN KEY (`image_id`) REFERENCES `image_metadata` (`id`),
  CONSTRAINT `fk_community_organisation` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `community_external_service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `community_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `external_service_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `community_id` (`community_id`),
  KEY `external_service_id` (`external_service_id`),
  CONSTRAINT `fk_community_service_community` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_community_service_service` FOREIGN KEY (`external_service_id`) REFERENCES `external_service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Links communities and external services.';


CREATE TABLE IF NOT EXISTS `community_member` (
  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'UUID string',
  `person_id` varchar(255) NOT NULL,
  `community_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `is_admin` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `community_member_unique` (`community_id`,`person_id`),
  KEY `person_id` (`person_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `fk_community_member_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_community_member_community` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organisation_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organisation_name_unique` (`organisation_id`,`name`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `fk_department_organisation` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `department_employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `employee_id` bigint(20) NOT NULL,
  `department_id` bigint(20) NOT NULL,
  `network_admin` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_employee_unique` (`employee_id`,`department_id`),
  KEY `employee_id` (`employee_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `fk_department_employee_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_department_employee_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organisation_id` bigint(20) unsigned NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `network_admin` int(11) NOT NULL DEFAULT '0',
  `job_title` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `default_network_relationship_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organisation_person_unique` (`organisation_id`,`person_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `person_id` (`person_id`),
  KEY `default_network_relationship_id` (`default_network_relationship_id`),
  CONSTRAINT `fk_employee_network_relationship` FOREIGN KEY (`default_network_relationship_id`) REFERENCES `network_relationship` (`id`),
  CONSTRAINT `fk_employee_organisation` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `external_device_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `external_device_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `type` varchar(100) NOT NULL COMMENT 'ENUM: zintouch. In the future: sensara, medido',
  PRIMARY KEY (`id`),
  KEY `external_device_id` (`external_device_id`),
  CONSTRAINT `fk_external_device_events_external_device` FOREIGN KEY (`external_device_id`) REFERENCES `external_devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `external_devices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(255) NOT NULL,
  `brand` varchar(45) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `fk_external_devices_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `external_service` (
  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'UUID',
  `version` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(2000) NOT NULL,
  `url_target` varchar(10) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `image_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `fk_external_service_image` FOREIGN KEY (`image_id`) REFERENCES `image_metadata` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='References to external services for display in the UI.';


CREATE TABLE IF NOT EXISTS `grid_settings` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `settings` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `fk_grid_settings_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `homecare_client` (
  `homecare_id` varchar(255) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  PRIMARY KEY (`homecare_id`,`client_id`),
  KEY `client_id` (`client_id`),
  KEY `homecare_id` (`homecare_id`),
  CONSTRAINT `fk_homecare_client_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_homecare_client_homecare` FOREIGN KEY (`homecare_id`) REFERENCES `homecare_institution` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `homecare_institution` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `homecare_people` (
  `homecare_id` varchar(255) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  PRIMARY KEY (`homecare_id`,`person_id`),
  KEY `person_id` (`person_id`),
  KEY `homecare_id` (`homecare_id`),
  CONSTRAINT `fk_homecare_people_homecare` FOREIGN KEY (`homecare_id`) REFERENCES `homecare_institution` (`id`),
  CONSTRAINT `fk_homecare_people_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `homes` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `external_source_id` varchar(50) DEFAULT NULL,
  `external_home_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `fk_homes_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `image_metadata` (
  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'UUID string',
  `date_created` datetime NOT NULL,
  `path` varchar(1024) NOT NULL,
  `file_name` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Image metadata table. Contains all the data related to an image.';


CREATE TABLE IF NOT EXISTS `logs` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `application` varchar(25) NOT NULL,
  `log_action` varchar(255) NOT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `action_id` varchar(255) DEFAULT NULL,
  `appointment_id` varchar(255) DEFAULT NULL,
  `person_id` varchar(255) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `client_id` (`client_id`),
  KEY `action_id` (`action_id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `person_id` (`person_id`),
  KEY `message_id` (`message_id`),
  CONSTRAINT `fk_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_logs_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_logs_action` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`),
  CONSTRAINT `fk_logs_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`),
  CONSTRAINT `fk_logs_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_logs_message` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `mail_sender_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from` varchar(255) NOT NULL,
  `reply_to` varchar(255) DEFAULT NULL,
  `mail_server_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mail_server_id` (`mail_server_id`),
  CONSTRAINT `fk_mail_sender_entries_mail_server` FOREIGN KEY (`mail_server_id`) REFERENCES `mail_servers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `mail_servers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `protocol` varchar(45) NOT NULL,
  `auth` int(11) NOT NULL DEFAULT '1',
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `message_like` (
  `message_id` varchar(255) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  PRIMARY KEY (`message_id`,`person_id`),
  KEY `person_id` (`person_id`),
  KEY `message_id` (`message_id`),
  CONSTRAINT `fk_message_like_message` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  CONSTRAINT `fk_message_like_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `message_read` (
  `message_id` varchar(255) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  PRIMARY KEY (`message_id`,`person_id`),
  KEY `person_id` (`person_id`),
  KEY `message_id` (`message_id`),
  CONSTRAINT `fk_message_read_message` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  CONSTRAINT `fk_message_read_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `messages` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `text` varchar(1024) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `image_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `client_id` (`client_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `fk_messages_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_messages_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_messages_image` FOREIGN KEY (`image_id`) REFERENCES `image_metadata` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `network_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `network_relationship` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `network_group_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`),
  KEY `network_group_id` (`network_group_id`),
  CONSTRAINT `fk_network_relationship_network_group` FOREIGN KEY (`network_group_id`) REFERENCES `network_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `network_relationship_text` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `network_relationship_id` bigint(20) NOT NULL,
  `language` varchar(25) NOT NULL,
  `text` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_relationship_language_unique` (`network_relationship_id`,`language`),
  KEY `network_relationship_id` (`network_relationship_id`),
  CONSTRAINT `fk_network_relationship_text_network_relationship` FOREIGN KEY (`network_relationship_id`) REFERENCES `network_relationship` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `notification` (
  `id` varchar(255) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `person_receiver_id` varchar(255) NOT NULL,
  `person_actor_id` varchar(255) NOT NULL,
  `date_notificationCreated` datetime NOT NULL,
  `appointment_id` varchar(255) DEFAULT NULL,
  `action_id` varchar(255) DEFAULT NULL,
  `changed_person_id` varchar(255) DEFAULT NULL,
  `notification_action` varchar(25) DEFAULT NULL,
  `person_victim_id` varchar(255) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `person_receiver_id` (`person_receiver_id`),
  KEY `person_actor_id` (`person_actor_id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `action_id` (`action_id`),
  KEY `changed_person_id` (`changed_person_id`),
  KEY `person_victim_id` (`person_victim_id`),
  CONSTRAINT `fk_notification_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_notification_receiver` FOREIGN KEY (`person_receiver_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_notification_actor` FOREIGN KEY (`person_actor_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_notification_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`),
  CONSTRAINT `fk_notification_action` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`),
  CONSTRAINT `fk_notification_changed_person` FOREIGN KEY (`changed_person_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fk_notification_victim` FOREIGN KEY (`person_victim_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `organisation` (
  `id` bigint(20) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_system` int(11) NOT NULL DEFAULT '0',
  `sortorder` int(11) NOT NULL DEFAULT '1000',
  `subdomain` varchar(45) DEFAULT NULL,
  `allow_sign_up` int(11) NOT NULL DEFAULT '0' COMMENT 'Allow sign-up through frontend?',
  `allow_network_creation` int(11) NOT NULL DEFAULT '0' COMMENT 'Allow network creation within organisation?',
  `has_communities` int(11) NOT NULL DEFAULT '0' COMMENT 'Community functionality enabled?',
  `has_tasks` int(11) DEFAULT NULL,
  `has_logbook` int(11) DEFAULT NULL,
  `has_socialmap` int(11) DEFAULT NULL,
  `has_timeline_on_dashboard` int(11) DEFAULT NULL,
  `has_emp_dpts` int(11) NOT NULL DEFAULT '0' COMMENT 'Employee and department functionality enabled?',
  `image_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `fk_organisation_image` FOREIGN KEY (`image_id`) REFERENCES `image_metadata` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `organisation_mail_sender_entry` (
  `organisation_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `mail_sender_entry_id` bigint(20) NOT NULL,
  PRIMARY KEY (`organisation_id`,`mail_sender_entry_id`),
  KEY `mail_sender_entry_id` (`mail_sender_entry_id`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `fk_organisation_mail_sender_entry_organisation` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`),
  CONSTRAINT `fk_organisation_mail_sender_entry_mail_sender_entry` FOREIGN KEY (`mail_sender_entry_id`) REFERENCES `mail_sender_entries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `person_mail_sender_entry` (
  `person_id` varchar(255) NOT NULL,
  `mail_sender_entry_id` bigint(20) NOT NULL,
  PRIMARY KEY (`person_id`,`mail_sender_entry_id`),
  KEY `mail_sender_entry_id` (`mail_sender_entry_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `fk_person_mail_sender_entry_mail_sender_entry` FOREIGN KEY (`mail_sender_entry_id`) REFERENCES `mail_sender_entries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_person_mail_sender_entry_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `persons` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `new_email` varchar(150) DEFAULT NULL,
  `date_email_changed` datetime DEFAULT NULL,
  `send_email_overview` varchar(20) NOT NULL DEFAULT 'NONE',
  `phone` varchar(50) DEFAULT NULL,
  `contactinfo` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_current_visit` datetime DEFAULT NULL,
  `date_email_overview_sent` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `date_no_image_mail_send` datetime DEFAULT NULL,
  `role` varchar(25) NOT NULL DEFAULT 'NOT_YET_REGISTERED',
  `externalid` int(11) DEFAULT '0',
  `date_deleted` datetime DEFAULT NULL,
  `date_last_visit` datetime DEFAULT NULL,
  `language` varchar(25) NOT NULL DEFAULT 'nl',
  `initials` varchar(3) DEFAULT NULL,
  `call_url` varchar(255) DEFAULT NULL,
  `birth_day` datetime DEFAULT NULL,
  `google_calendar_id` varchar(255) DEFAULT NULL,
  `google_sync_option` varchar(25) NOT NULL DEFAULT 'ALL_APP',
  `is_professional` int(11) NOT NULL DEFAULT '0',
  `is_saml` int(11) NOT NULL DEFAULT '0',
  `mobile_pin_code` varchar(255) NOT NULL DEFAULT '00000',
  `is_tour_done` int(11) NOT NULL DEFAULT '0',
  `date_tour_done` datetime DEFAULT NULL,
  `show_help_on_startup` int(11) NOT NULL DEFAULT '1',
  `date_preauthorization` datetime DEFAULT NULL,
  `time_zone` varchar(64) NOT NULL DEFAULT 'Europe/Amsterdam',
  `old_name` varchar(150) DEFAULT NULL,
  `old_email` varchar(150) DEFAULT NULL,
  `send_email_engagement` int(11) NOT NULL DEFAULT '0',
  `image_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `send_email_chat` int(11) NOT NULL DEFAULT '1' COMMENT 'Flag that determines if email notifying a person of new unread chat messages should be sent.',
  `send_email_community_update` int(11) NOT NULL DEFAULT '0' COMMENT 'Flag that determines if email notifying a person of new community posts should be sent.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_unique` (`email`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `fk_persons_image` FOREIGN KEY (`image_id`) REFERENCES `image_metadata` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `rbac_assignment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` varchar(255) NOT NULL,
  `rbac_item_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `person_rbac_item_unique` (`person_id`,`rbac_item_id`),
  KEY `person_id` (`person_id`),
  KEY `rbac_item_id` (`rbac_item_id`),
  CONSTRAINT `fk_rbac_assignment_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rbac_assignment_rbac_item` FOREIGN KEY (`rbac_item_id`) REFERENCES `rbac_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `rbac_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(45) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `rbac_item_child` (
  `parent_id` bigint(20) NOT NULL,
  `child_id` bigint(20) NOT NULL,
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `parent_id` (`parent_id`),
  KEY `child_id` (`child_id`),
  CONSTRAINT `fk_rbac_item_child_child` FOREIGN KEY (`child_id`) REFERENCES `rbac_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rbac_item_child_parent` FOREIGN KEY (`parent_id`) REFERENCES `rbac_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `recurrences` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `weekdays` varchar(7) DEFAULT NULL,
  `frequencytype` varchar(10) DEFAULT NULL,
  `app_interval` int(11) DEFAULT NULL,
  `maxoccurrences` int(11) DEFAULT NULL,
  `date_start` datetime NOT NULL,
  `date_finish` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report` (
  `id` varchar(255) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `report_type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `person_id` (`person_id`),
  KEY `report_type_id` (`report_type_id`),
  CONSTRAINT `fk_report_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_report_type` FOREIGN KEY (`report_type_id`) REFERENCES `report_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_report_option` (
  `report_id` varchar(255) NOT NULL,
  `report_option_id` bigint(20) NOT NULL,
  PRIMARY KEY (`report_id`,`report_option_id`),
  KEY `report_option_id` (`report_option_id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `fk_report_report_option_report` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_report_option_report_option` FOREIGN KEY (`report_option_id`) REFERENCES `report_option` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_option` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `report_type_id` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_type_name_unique` (`report_type_id`,`name`),
  KEY `report_type_id` (`report_type_id`),
  CONSTRAINT `fk_report_option_report_type` FOREIGN KEY (`report_type_id`) REFERENCES `report_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_request` (
  `id` varchar(255) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `report_type_id` bigint(20) NOT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `time_shown` datetime DEFAULT NULL,
  `time_dismissed` datetime DEFAULT NULL,
  `time_responded` datetime DEFAULT NULL,
  `report_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `person_id` (`person_id`),
  KEY `report_id` (`report_id`),
  KEY `report_type_id` (`report_type_id`),
  CONSTRAINT `fk_report_request_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_request_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_report_request_report` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_report_request_report_type` FOREIGN KEY (`report_type_id`) REFERENCES `report_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `report_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `sensor_events` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `sensor_id` varchar(255) NOT NULL,
  `remote_event_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sensor_id` (`sensor_id`),
  CONSTRAINT `fk_sensor_events_sensor` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `sensors` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `active` int(11) NOT NULL,
  `home_id` varchar(255) NOT NULL,
  `showSensor` int(11) NOT NULL DEFAULT '0',
  `external_source_id` varchar(50) DEFAULT NULL,
  `external_sensor_id` varchar(50) DEFAULT NULL,
  `type` varchar(25) NOT NULL DEFAULT 'MOTION',
  `image_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `home_id` (`home_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `fk_sensors_home` FOREIGN KEY (`home_id`) REFERENCES `homes` (`id`),
  CONSTRAINT `fk_sensors_image` FOREIGN KEY (`image_id`) REFERENCES `image_metadata` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `settings` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `setting_key` varchar(150) NOT NULL,
  `setting_value` varchar(2000) NOT NULL,
  `keytype` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key_unique` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DELIMITER //
CREATE PROCEDURE `update_sensor_events`()
    READS SQL DATA
BEGIN
    DECLARE seid VARCHAR(255);
    DECLARE no_more_rows BOOLEAN;
    DECLARE loop_cntr INT DEFAULT 0;
    DECLARE num_rows INT DEFAULT 0;

    DECLARE curs CURSOR FOR select id from sensors;
    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = TRUE;

    OPEN curs;

    select FOUND_ROWS() into num_rows;

    the_loop: LOOP
        FETCH curs INTO seid;

        CALL update_sensor_events_by_sensor_id(seid);

        -- break out of the loop if
        -- 1) there were no records, or
        -- 2) we've processed them all
        IF no_more_rows THEN
            CLOSE curs;
            LEAVE the_loop;
        END IF;

        -- count the number of times looped
        SET loop_cntr = loop_cntr + 1;
    END LOOP the_loop;

    -- 'print' the output so we can see they are the same
    select num_rows, loop_cntr;

END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `update_sensor_events_by_sensor_id`(IN sensorId VARCHAR(255))
    READS SQL DATA
BEGIN
    DECLARE seid VARCHAR(255);
    DECLARE startDate datetime;
    DECLARE endDate datetime;
   
    DECLARE idxId VARCHAR(255) DEFAULT null;
    DECLARE idxEndDate datetime DEFAULT null;

    DECLARE no_more_rows BOOLEAN;
    DECLARE loop_cntr INT DEFAULT 0;
    DECLARE num_rows INT DEFAULT 0;

    DECLARE curs CURSOR FOR select id, start_date, end_date from sensor_events where sensor_id = sensorId order by end_date;
    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = TRUE;

    OPEN curs;

    select FOUND_ROWS() into num_rows;

    the_loop: LOOP
        FETCH curs INTO seid, startDate, endDate;

        IF idxId is null THEN
            SET idxId = seid;
            SET idxEndDate = endDate;
        ELSE
            IF idxEndDate <= startDate THEN
                SET idxId = seid;
                SET idxEndDate = endDate;
            ELSE
                UPDATE sensor_events SET end_date = endDate where id = idxId;
                DELETE FROM sensor_events WHERE id = seid;
                SET idxEndDate = endDate;
            END IF;
        END IF;

        -- break out of the loop if
        -- 1) there were no records, or
        -- 2) we've processed them all
        IF no_more_rows THEN
            CLOSE curs;
            LEAVE the_loop;
        END IF;

        -- the equivalent of a 'print statement' in a stored procedure
        -- it simply displays output for each loop
        -- select seid, startDate, endDate, idxEndDate;

        -- count the number of times looped
        SET loop_cntr = loop_cntr + 1;
    END LOOP the_loop;

    -- 'print' the output so we can see they are the same
    select num_rows, loop_cntr;

END//
DELIMITER ;


CREATE TABLE IF NOT EXISTS `user_device` (
  `id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `device_type` varchar(25) NOT NULL,
  `useragent` varchar(255) NOT NULL,
  `device_push_token` varchar(255) DEFAULT NULL,
  `renew_token_id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_renew_token_unique` (`user_id`,`renew_token_id`),
  CONSTRAINT `fk_user_device_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `person_id` varchar(255) NOT NULL,
  `date_notification` datetime DEFAULT NULL,
  `old_username` varchar(50) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique` (`username`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `fk_users_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE OR REPLACE VIEW `v_persons` AS
SELECT
  `p`.`id` AS `id`,
  `p`.`name` AS `name`,
  `p`.`email` AS `email`,
  `p`.`image_id` AS `image_id`,
  `o`.`id` AS `employee_organisation_id`,
  `o`.`name` AS `employee_organisation_name`,
  `co`.`id` AS `client_organisation_id`,
  `co`.`name` AS `client_organisation_name`,
  `e`.`network_admin` AS `organisation_admin`,
  `p`.`date_created` AS `date_created`,
  `p`.`date_modified` AS `date_modified`,
  `p`.`date_deleted` AS `date_deleted`,
  `p`.`role` AS `role`,
  (SELECT MAX(`l`.`date_created`) FROM `logs` `l` WHERE (`l`.`user_id` = `u`.`id`)) AS `last_activity`,
  (SELECT MAX(`l`.`date_created`) FROM `logs` `l` WHERE ((`l`.`user_id` = `u`.`id`) AND (`l`.`log_action` = 'LOGIN'))) AS `last_login`,
  `u`.`id` AS `user_id`,
  `e`.`id` AS `employee_id`,
  `p`.`send_email_overview` AS `send_email_overview`,
  `p`.`send_email_engagement` AS `send_email_engagement`,
  (SELECT group_concat(`ri`.`id` SEPARATOR ',')
    FROM `rbac_assignment` `ra`
    JOIN `rbac_item` `ri` ON `ra`.`rbac_item_id` = `ri`.`id`
    WHERE ((`ra`.`person_id` = `p`.`id`) AND (`ri`.`type` = 'PERMISSION'))
  ) AS `permissions`,
  group_concat(`d`.`name` SEPARATOR ', ') AS `department_names`
FROM `persons` `p` 
LEFT JOIN `employee` `e` ON `e`.`person_id` = `p`.`id`
LEFT JOIN `organisation` `o` ON `e`.`organisation_id` = `o`.`id`
LEFT JOIN `department_employee` `de` ON `de`.`employee_id` = `e`.`id`
LEFT JOIN `department` `d` ON `d`.`id` = `de`.`department_id`
LEFT JOIN `users` `u` ON `u`.`person_id` = `p`.`id`
LEFT JOIN `clients` `c` ON `c`.`person_id` = `p`.`id`
LEFT JOIN `organisation` `co` ON `co`.`id` = `c`.`organisation_id`
WHERE (isnull(`e`.`id`) OR ((`e`.`id` IS NOT NULL) AND isnull(`e`.`date_deleted`)))
group by
  `id`,
  `name`,
  `email`,
  `image_id`,
  `employee_organisation_id`,
  `employee_organisation_name`,
  `client_organisation_id`,
  `client_organisation_name`,
  `date_created`,
  `date_modified`,
  `date_deleted`,
  `role`,
  `last_activity`,
  `last_login`,
  `user_id`,
  `employee_id`,
  `send_email_overview`,
  `send_email_engagement`;


CREATE TABLE IF NOT EXISTS `weeknotes` (
  `id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `week` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `description` text,
  `client` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client` (`client`),
  CONSTRAINT `fk_weeknotes_client` FOREIGN KEY (`client`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `zintouch_connect_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `zintouch_notification_id` bigint(20) NOT NULL,
  `zt_id` int(11) NOT NULL,
  `role` varchar(10) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `hz_client_id` varchar(45) NOT NULL,
  `hz_person_id` varchar(45) NOT NULL,
  `hz_client_group` varchar(45) DEFAULT NULL,
  `time` bigint(20) NOT NULL,
  `hzhash` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zintouch_notification_id` (`zintouch_notification_id`),
  CONSTRAINT `fk_zintouch_connect_notifications_notification` FOREIGN KEY (`zintouch_notification_id`) REFERENCES `zintouch_notifications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `zintouch_device_persons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` varchar(255) NOT NULL,
  `zintouch_device_id` bigint(20) NOT NULL,
  `role` varchar(6) NOT NULL,
  `zt_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zintouch_device_id` (`zintouch_device_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `fk_zintouch_device_persons_device` FOREIGN KEY (`zintouch_device_id`) REFERENCES `zintouch_devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_zintouch_device_persons_person` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `zintouch_devices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `external_device_id` bigint(20) NOT NULL,
  `device_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `external_device_id` (`external_device_id`),
  CONSTRAINT `fk_zintouch_devices_device` FOREIGN KEY (`external_device_id`) REFERENCES `external_devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `zintouch_event_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `zintouch_notification_id` bigint(20) NOT NULL,
  `event_time` bigint(20) NOT NULL COMMENT 'Unix time',
  `event_caller_id` int(11) NOT NULL COMMENT 'pstn call',
  `event_url` varchar(255) DEFAULT NULL,
  `event_location` varchar(100) DEFAULT NULL,
  `event_notes` varchar(1024) DEFAULT NULL,
  `device_type` varchar(45) DEFAULT NULL,
  `device_battery` int(11) DEFAULT NULL COMMENT 'In percentage (0 to 100)',
  `location_time` bigint(20) DEFAULT NULL COMMENT 'Unix time',
  `location_latitude` varchar(45) DEFAULT NULL COMMENT 'decimal degrees',
  `location_longitude` varchar(45) DEFAULT NULL COMMENT 'decimal degrees',
  `location_altitude` int(11) DEFAULT NULL COMMENT 'm',
  `location_speed` int(11) DEFAULT NULL COMMENT 'km/h',
  `location_direction` int(11) DEFAULT NULL COMMENT 'degrees',
  `geo_zone` int(11) DEFAULT NULL COMMENT 'Corresponding GEO zone in Zintouch system. 1 to 3',
  `geo_name` varchar(45) DEFAULT NULL COMMENT 'Name of the corresponding GEO zone in the Zintouch system',
  `geo_type` varchar(45) DEFAULT NULL,
  `geo_latitude` varchar(45) DEFAULT NULL COMMENT '[decimal degrees]. Longitude of the center of the GEO zone circle',
  `geo_longitude` varchar(45) DEFAULT NULL COMMENT '[decimal degrees]. Longitude of the center of the GEO zone circle',
  `geo_radius` int(11) DEFAULT NULL COMMENT '[m]. Radius of the GEO zone circle. 75 to 10000.',
  `sip_domain` varchar(255) DEFAULT NULL,
  `sip_username` varchar(100) DEFAULT NULL,
  `sip_password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `zintouch_notification_id` (`zintouch_notification_id`),
  CONSTRAINT `fk_zintouch_event_notifications_zintouch_notification` FOREIGN KEY (`zintouch_notification_id`) REFERENCES `zintouch_notifications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `zintouch_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `external_device_event_id` bigint(20) NOT NULL,
  `event_id` int(11) NOT NULL,
  `event_type` varchar(45) NOT NULL COMMENT 'ENUM:  battery_down, battery_low, battery_up, client_connect, client_disconnect, device_down, device_up, geo_alarm, person_connect, person_disconnect, sos_alarm',
  `user_method` varchar(45) NOT NULL COMMENT 'ENUM: command, connect_notification, event_notification, heartbeat',
  PRIMARY KEY (`id`),
  KEY `external_device_event_id` (`external_device_event_id`),
  CONSTRAINT `fk_zintouch_notifications_external_device_event` FOREIGN KEY (`external_device_event_id`) REFERENCES `external_device_events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `zintouch_server` (
  `device_id` varchar(100) NOT NULL,
  `last_heartbeat` datetime NOT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
