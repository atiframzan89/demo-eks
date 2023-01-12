-- ************************************************************
-- This SQL file will DROP all the objects and 
-- then it will DROP the Database.
-- ************************************************************

DROP TABLE IF EXISTS `sequent_dsp`.`metadata` ;
DROP TABLE IF EXISTS `sequent_dsp`.`request_status` ;
DROP TABLE IF EXISTS `sequent_dsp`.`kafka_failover`;

DROP SCHEMA IF EXISTS sequent_dsp;
