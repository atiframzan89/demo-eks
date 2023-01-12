-- -----------------------------------------------------
-- Schema sequent_dsp
-- -----------------------------------------------------
-- CREATE SCHEMA `sequent_dsp` DEFAULT CHARACTER SET utf8;
-- USE `sequent_dsp`;

-- -----------------------------------------------------
-- Table `sequent_dsp`.`metadata`
-- -----------------------------------------------------
CREATE TABLE `sequent_dsp`.`metadata` (
  `owner_id`  VARCHAR(50) 	NOT NULL COMMENT '-',
  `key`       VARCHAR(50)	NOT NULL COMMENT '-',
  `value`     VARCHAR(256)	NOT NULL COMMENT '-',
  `type`      VARCHAR(50) 	NOT NULL COMMENT '-',
  `is_active` INT(11) 		NOT NULL COMMENT '-'
) COMMENT='-';

-- -----------------------------------------------------
-- Table `sequent_dsp`.`kafka_failover`
-- -----------------------------------------------------
CREATE TABLE `sequent_dsp`.`kafka_failover` (
  `log_id`      VARCHAR(150) NOT NULL COMMENT '-',
  `event_date`  TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT 'Time-Date entry of the event from source, DB supplied if not set.',
  `message`     VARCHAR(500) NOT NULL COMMENT '-',
  `processed`   TINYINT(1) NOT NULL DEFAULT '0' COMMENT '-',
  INDEX `idx_kafka_failover_log_id` (`log_id`)
) COMMENT='-';


-- -----------------------------------------------------
-- Table `sequent_dsp`.`request_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sequent_dsp`.`request_status` (
  `correlation_id` varchar(130) NOT NULL COMMENT '-',
  `input_filename` varchar(130) NULL  COMMENT '-',
  `current_status` varchar(130) NULL COMMENT '-',
  `action_type` varchar(130) NULL COMMENT '-',
  `profile_name` varchar(130) NULL COMMENT '-',
  `upload_time` BIGINT(20) 	DEFAULT NULL COMMENT '-',
  `process_time` BIGINT(20) DEFAULT NULL COMMENT '-',
  `duration` bigint NULL COMMENT '-',
  `failure_reason` varchar(500) NULL COMMENT '-',
  `meta` varchar(200) NULL COMMENT '-',
  `bucket_name` varchar(200) NULL COMMENT '-',
  PRIMARY KEY (`correlation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='-';