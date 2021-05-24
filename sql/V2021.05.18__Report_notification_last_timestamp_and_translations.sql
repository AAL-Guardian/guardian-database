/**
 * Author:  moverkamp
 * Created: May 18, 2021
 */

INSERT INTO `settings` (`id`, `version`, `setting_key`, `setting_value`, `keytype`) VALUES
  ('92bf0c52-47bb-49dd-bd54-2e06774d0f94', 0, 'REPORT_LAST_EMAIL_NOTIFICATION_TIMESTAMP', '2021-05-18T00:00:00.000', 'LOCAL_DATE_TIME');


-- Various translations for the notification e-mails.
-- To prevent a possible clash with Misty translations, a non-existing column name is used.

-- Translations for report type names as will be used in the notification e-mails.
INSERT INTO `translations` (`table_name`, `column_name`, `item_id`, `language`, `translation`) VALUES
  ('report_type', 'email_name', 1, 'en', 'wellbeing'),
  ('report_type', 'email_name', 2, 'en', 'sleep'),
  ('report_type', 'email_name', 3, 'en', 'medication'),
  ('report_type', 'email_name', 4, 'en', 'meal'),
  ('report_type', 'email_name', 1, 'nl', 'welzijn'),
  ('report_type', 'email_name', 2, 'nl', 'slaap'),
  ('report_type', 'email_name', 3, 'nl', 'medicatie'),
  ('report_type', 'email_name', 4, 'nl', 'maaltijd');

-- Translations for pattern categories for the notification e-mails.
INSERT INTO `translations` (`table_name`, `column_name`, `item_id`, `language`, `translation`) VALUES
  ('pattern_category', 'email_name', 1, 'en', 'sleep'),
  ('pattern_category', 'email_name', 2, 'en', 'rest'),
  ('pattern_category', 'email_name', 3, 'en', 'meal'),
  ('pattern_category', 'email_name', 4, 'en', 'breakfast'),
  ('pattern_category', 'email_name', 5, 'en', 'lunch'),
  ('pattern_category', 'email_name', 6, 'en', 'dinner'),
  ('pattern_category', 'email_name', 7, 'en', 'fruit'),
  ('pattern_category', 'email_name', 8, 'en', 'snack 1'),
  ('pattern_category', 'email_name', 9, 'en', 'snack 2'),
  ('pattern_category', 'email_name', 10, 'en', 'activity'),
  ('pattern_category', 'email_name', 1, 'nl', 'slaap'),
  ('pattern_category', 'email_name', 2, 'nl', 'rust'),
  ('pattern_category', 'email_name', 3, 'nl', 'maaltijd'),
  ('pattern_category', 'email_name', 4, 'nl', 'ontbijt'),
  ('pattern_category', 'email_name', 5, 'nl', 'middageten'),
  ('pattern_category', 'email_name', 6, 'nl', 'avondeten'),
  ('pattern_category', 'email_name', 7, 'nl', 'fruit'),
  ('pattern_category', 'email_name', 8, 'nl', 'tussendoortje 1'),
  ('pattern_category', 'email_name', 9, 'nl', 'tussendoortje 2'),
  ('pattern_category', 'email_name', 10, 'nl', 'activiteit');

-- Translations of question options for the notification e-mails.
INSERT INTO `translations` (`table_name`, `column_name`, `item_id`, `language`, `translation`) VALUES
  ('report_question_option', 'email_name', 1, 'en', 'very good'),
  ('report_question_option', 'email_name', 2, 'en', 'fairly good'),
  ('report_question_option', 'email_name', 3, 'en', 'fairly bad'),
  ('report_question_option', 'email_name', 4, 'en', 'very bad'),
  ('report_question_option', 'email_name', 5, 'en', 'pain'),
  ('report_question_option', 'email_name', 6, 'en', 'headache'),
  ('report_question_option', 'email_name', 7, 'en', 'nauseous'),
  ('report_question_option', 'email_name', 8, 'en', 'dizziness'),
  ('report_question_option', 'email_name', 9, 'en', 'loneliness'),
  ('report_question_option', 'email_name', 10, 'en', 'worry'),
  ('report_question_option', 'email_name', 11, 'en', 'boredom'),
  ('report_question_option', 'email_name', 12, 'en', 'tension'),
  ('report_question_option', 'email_name', 13, 'en', 'other'),
  ('report_question_option', 'email_name', 14, 'en', 'very good'),
  ('report_question_option', 'email_name', 15, 'en', 'fairly good'),
  ('report_question_option', 'email_name', 16, 'en', 'fairly bad'),
  ('report_question_option', 'email_name', 17, 'en', 'very bad'),
  ('report_question_option', 'email_name', 18, 'en', 'cannot get to sleep within 30 minutes'),
  ('report_question_option', 'email_name', 19, 'en', 'wake up early'),
  ('report_question_option', 'email_name', 20, 'en', 'have to use the bathroom'),
  ('report_question_option', 'email_name', 21, 'en', 'cannot breathe comfortably'),
  ('report_question_option', 'email_name', 22, 'en', 'cough or snore loudly'),
  ('report_question_option', 'email_name', 23, 'en', 'feel too cold'),
  ('report_question_option', 'email_name', 24, 'en', 'feel too hot'),
  ('report_question_option', 'email_name', 25, 'en', 'have pain'),
  ('report_question_option', 'email_name', 26, 'en', 'other'),
  ('report_question_option', 'email_name', 27, 'en', 'no'),
  ('report_question_option', 'email_name', 28, 'en', 'yes'),
  ('report_question_option', 'email_name', 29, 'en', 'no'),
  ('report_question_option', 'email_name', 30, 'en', 'yes'),
  ('report_question_option', 'email_name', 1, 'nl', 'heel goed'),
  ('report_question_option', 'email_name', 2, 'nl', 'redelijk goed'),
  ('report_question_option', 'email_name', 3, 'nl', 'redelijk slecht'),
  ('report_question_option', 'email_name', 4, 'nl', 'heel slecht'),
  ('report_question_option', 'email_name', 5, 'nl', 'pijn'),
  ('report_question_option', 'email_name', 6, 'nl', 'hoofdpijn'),
  ('report_question_option', 'email_name', 7, 'nl', 'misselijk'),
  ('report_question_option', 'email_name', 8, 'nl', 'duizelig'),
  ('report_question_option', 'email_name', 9, 'nl', 'eenzaam'),
  ('report_question_option', 'email_name', 10, 'nl', 'zorgen'),
  ('report_question_option', 'email_name', 11, 'nl', 'verveling'),
  ('report_question_option', 'email_name', 12, 'nl', 'spanning'),
  ('report_question_option', 'email_name', 13, 'nl', 'anders'),
  ('report_question_option', 'email_name', 14, 'nl', 'heel goed'),
  ('report_question_option', 'email_name', 15, 'nl', 'redelijk goed'),
  ('report_question_option', 'email_name', 16, 'nl', 'redelijk slecht'),
  ('report_question_option', 'email_name', 17, 'nl', 'heel slecht'),
  ('report_question_option', 'email_name', 18, 'nl', 'kom niet in slaap binnen 30 minuten'),
  ('report_question_option', 'email_name', 19, 'nl', 'word vroeg wakker'),
  ('report_question_option', 'email_name', 20, 'nl', 'moet naar de wc'),
  ('report_question_option', 'email_name', 21, 'nl', 'kan niet goed ademen'),
  ('report_question_option', 'email_name', 22, 'nl', 'hoesten of snurken'),
  ('report_question_option', 'email_name', 23, 'nl', 'te koud'),
  ('report_question_option', 'email_name', 24, 'nl', 'te warm'),
  ('report_question_option', 'email_name', 25, 'nl', 'heb pijn'),
  ('report_question_option', 'email_name', 26, 'nl', 'anders'),
  ('report_question_option', 'email_name', 27, 'nl', 'nee'),
  ('report_question_option', 'email_name', 28, 'nl', 'ja'),
  ('report_question_option', 'email_name', 29, 'nl', 'nee'),
  ('report_question_option', 'email_name', 30, 'nl', 'ja');
