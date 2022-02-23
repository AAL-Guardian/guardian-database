/**
 * Author:  moverkamp
 * Created: Feb 23, 2022
 */

-- Index to make queries via the API more efficient.
ALTER TABLE `guardian_event`
  ADD INDEX `clients_id_name_timestamp` (`clients_id` ASC, `event_name` ASC, `timestamp` ASC);
