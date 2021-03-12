ALTER TABLE `guardian_dev`.`guardian_event` 
DROP FOREIGN KEY `fk_guardian_event_clients1`;

ALTER TABLE `guardian_dev`.`guardian_event` 
CHANGE COLUMN `timestamp` `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
DROP INDEX `fk_guardian_event_clients1_idx` ;