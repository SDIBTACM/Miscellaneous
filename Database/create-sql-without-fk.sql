-- MySQL Script generated by MySQL Workbench
-- Sunday, March 31, 2019 PM05:14:54 CST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='';

-- -----------------------------------------------------
-- Schema OnlineJudge
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `OnlineJudge` ;

-- -----------------------------------------------------
-- Schema OnlineJudge
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OnlineJudge` DEFAULT CHARACTER SET utf8mb4 ;
SHOW WARNINGS;
USE `OnlineJudge` ;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `username` VARCHAR(64) NOT NULL DEFAULT '',
  `nickname` VARCHAR(64) NOT NULL DEFAULT '',
  `password` VARCHAR(255) NOT NULL DEFAULT '',
  `email` VARCHAR(255) NOT NULL DEFAULT '',
  `email_verified_at` TIMESTAMP NOT NULL DEFAULT 0,
  `school` VARCHAR(32) NOT NULL DEFAULT '',
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT '-1: lock\n0: normal\n1: need verify by admin',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_email` (`deleted_at` ASC, `email` ASC),
  UNIQUE INDEX `uq_username` (`deleted_at` ASC, `username` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`login_logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`login_logs` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`login_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `user_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `ip` VARCHAR(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX `idx_user` (`user_id` ASC),
  INDEX `idx_login_time` (`created_at` DESC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`problems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`problems` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`problems` (
  `id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `title` VARCHAR(128) NOT NULL DEFAULT '',
  `owner_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `source` VARCHAR(255) NOT NULL DEFAULT '',
  `time_limit` INT UNSIGNED NOT NULL DEFAULT 1000 COMMENT 'mirco seconds',
  `memory_limit` INT UNSIGNED NOT NULL DEFAULT 1024 COMMENT 'kbytes',
  `is_special_judge` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0: not special judge\n1: special judge',
  `similar_from` INT UNSIGNED NOT NULL DEFAULT 0,
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT '0: normal\n1: hide',
  `testdata_updated_at` TIMESTAMP NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `idx_user` (`owner_id` ASC),
  INDEX `idx_source` (`source` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`contests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`contests` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`contests` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `owner_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `start_at` TIMESTAMP NOT NULL DEFAULT 0,
  `end_before` TIMESTAMP NOT NULL DEFAULT 0,
  `privilege` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0: public\n1: private\n2: protect\n3: need register',
  `password` VARCHAR(255) NOT NULL DEFAULT '',
  `register_start_at` TIMESTAMP NOT NULL DEFAULT 0,
  `register_end_before` TIMESTAMP NOT NULL DEFAULT 0,
  `allow_language` BIGINT NOT NULL DEFAULT 0 COMMENT '0 is all allow,if a bit set 1, that mean not allow',
  `lock_rank_at` TINYINT NOT NULL DEFAULT 0 COMMENT '0 for no, 20 for at last 20% time',
  PRIMARY KEY (`id`),
  INDEX `idx_owner` (`owner_id` ASC),
  INDEX `idx_start` (`start_at` ASC),
  INDEX `idx_privilege` (`privilege` ASC))
ENGINE = InnoDB
COMMENT = '竞赛信息';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`options`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`options` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`options` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `key` VARCHAR(64) NOT NULL DEFAULT '',
  `value` TEXT NOT NULL DEFAULT '' COMMENT 'json',
  `comment` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uk_id` (`key` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`contest_problems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`contest_problems` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`contest_problems` (
  `id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `contest_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `problem_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `title` VARCHAR(128) NOT NULL DEFAULT '',
  `problem_order` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'the serial number of problem',
  PRIMARY KEY (`id`),
  INDEX `idx_contest` (`contest_id` ASC),
  INDEX `idx_problem` (`problem_id` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`contest_registers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`contest_registers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`contest_registers` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `contest_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `actual_name` VARCHAR(64) NOT NULL DEFAULT '',
  `college` VARCHAR(64) NOT NULL DEFAULT '',
  `discipline` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'it means: a branch of knowledge, typically one studied in higher education.',
  `sex` TINYINT NOT NULL DEFAULT 1 COMMENT '1: male\n2: female',
  `status` TINYINT NOT NULL DEFAULT -1 COMMENT '-1: pending\n0: accept\n1: wait for update info\n2: reject',
  PRIMARY KEY (`id`),
  INDEX `idx_user` (`user_id` ASC),
  INDEX `idx_contest` (`contest_id` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`contest_results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`contest_results` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`contest_results` (
  `id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `contest_problem_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `contest_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `status` INT NOT NULL DEFAULT 0 COMMENT 'value mean submit times',
  `ac_at` TIMESTAMP NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `idx_contest_problem` (`contest_problem_id` ASC),
  INDEX `idx_user` (`user_id` ASC),
  INDEX `idx_contest` (`contest_id` ASC),
  UNIQUE INDEX `uq_user_contest_contest_problem` (`contest_problem_id` ASC, `user_id` ASC, `contest_id` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`mails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`mails` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`mails` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `from_user_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `to_user_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `topic` VARCHAR(255) NOT NULL DEFAULT '',
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT '0 :new mail\n1 :has read',
  PRIMARY KEY (`id`),
  INDEX `idx_to_user` (`to_user_id` ASC),
  INDEX `idx_from_user` (`from_user_id` ASC),
  INDEX `idx_time` (`created_at` DESC),
  INDEX `idx_status` (`status` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`solutions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`solutions` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`solutions` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `owner_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `contest_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `problem_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `contest_problem_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'sumbit from contest/exam{id}',
  `hash` VARCHAR(128) NOT NULL DEFAULT '',
  `lang` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `result` TINYINT NOT NULL DEFAULT -2 COMMENT '-3:RJ WAIT\n-2:WAIT\n-1:RUN\n0:AC\n1:WA\n2:PE\n3:OLE\n4:TLE\n5:RE\n6:SE',
  `time_used` INT UNSIGNED NOT NULL DEFAULT 0,
  `memory_used` INT UNSIGNED NOT NULL DEFAULT 0,
  `similar_at` INT UNSIGNED NOT NULL DEFAULT 0,
  `similar_percent` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `idx_user` (`owner_id` ASC),
  INDEX `idx_problem` (`problem_id` ASC),
  INDEX `idx_contest_problem` (`contest_problem_id` ASC),
  INDEX `idx_result` (`result` ASC),
  INDEX `idx_contest_id` (`contest_id` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`discuss_topics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`discuss_topics` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`discuss_topics` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `owner_id` INT UNSIGNED NOT NULL,
  `contest_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'submit for {problem_id|contest_id}id',
  `problem_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT '0: normal\n1: top',
  `views` INT UNSIGNED NOT NULL DEFAULT 0,
  `replies` INT UNSIGNED NOT NULL DEFAULT 0,
  `title` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_user` (`owner_id` ASC),
  INDEX `idx_contest` (`contest_id` ASC),
  INDEX `idx_problem` (`problem_id` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`discuss_posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`discuss_posts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`discuss_posts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `owner_id` INT UNSIGNED NOT NULL,
  `topic_id` INT UNSIGNED NOT NULL,
  `status` TINYINT NOT NULL COMMENT '-1: locked\n0: normal\n1: toped',
  PRIMARY KEY (`id`),
  INDEX `idx_topic_id` (`topic_id` ASC),
  INDEX `idx_owner` (`owner_id` ASC),
  INDEX `idx_status` (`status` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`contest_privileges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`contest_privileges` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`contest_privileges` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `contest_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `type` INT NOT NULL DEFAULT 0 COMMENT '-1: deny\n0: allow take part in\n1: allow manage',
  PRIMARY KEY (`id`),
  INDEX `idx_user` (`user_id` ASC),
  INDEX `idx_contest` (`contest_id` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`news`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`news` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`news` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `owner_id` INT UNSIGNED NOT NULL,
  `title` VARCHAR(64) NOT NULL,
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT '0: normal\n1: hide',
  PRIMARY KEY (`id`),
  INDEX `idx_owner` (`owner_id` ASC),
  INDEX `idx_status` (`status` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`solution_codes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`solution_codes` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`solution_codes` (
  `solution_id` INT UNSIGNED NOT NULL,
  `code` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`solution_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`groups` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`groups` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NOT NULL DEFAULT 0,
  `name` VARCHAR(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`user_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`user_groups` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`user_groups` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` INT UNSIGNED NOT NULL,
  `group_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_user_id` (`user_id` ASC),
  INDEX `idx_group_id` (`group_id` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`problem_descriptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`problem_descriptions` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`problem_descriptions` (
  `problem_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` TEXT NOT NULL DEFAULT '',
  `input` TEXT NOT NULL DEFAULT '',
  `output` TEXT NOT NULL DEFAULT '',
  `sample` TEXT NOT NULL DEFAULT '' COMMENT 'include sample input and sample output',
  `hint` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`problem_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`solution_ full_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`solution_ full_result` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`solution_ full_result` (
  `solution_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`solution_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`contest_ip_limits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`contest_ip_limits` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`contest_ip_limits` (
  `contest_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deny_ip` TEXT NOT NULL DEFAULT '' COMMENT 'JSON CIDR',
  `allow_ip` TEXT NOT NULL DEFAULT '' COMMENT 'JSON CIDR',
  PRIMARY KEY (`contest_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`mail_contexts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`mail_contexts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`mail_contexts` (
  `mail_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `context` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`mail_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`news_contexts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`news_contexts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`news_contexts` (
  `news_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `context` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`news_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OnlineJudge`.`discuss_post_contexts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineJudge`.`discuss_post_contexts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OnlineJudge`.`discuss_post_contexts` (
  `discuss_post_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `context` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`discuss_post_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `OnlineJudge`.`options`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineJudge`;
INSERT INTO `OnlineJudge`.`options` (`id`, `created_at`, `update_at`, `key`, `value`, `comment`) VALUES (1, DEFAULT, DEFAULT, 'system_status', '[0]', '0: normal, 1: in vip contest');
INSERT INTO `OnlineJudge`.`options` (`id`, `created_at`, `update_at`, `key`, `value`, `comment`) VALUES (2, DEFAULT, DEFAULT, 'deny_login_ips', '{}', 'the ip list that do not allow login');
INSERT INTO `OnlineJudge`.`options` (`id`, `created_at`, `update_at`, `key`, `value`, `comment`) VALUES (3, DEFAULT, DEFAULT, 'allow_login_ips', '{}', 'the ip list that which can login; if not empty, it will be checked first');
INSERT INTO `OnlineJudge`.`options` (`id`, `created_at`, `update_at`, `key`, `value`, `comment`) VALUES (4, DEFAULT, DEFAULT, 'deny_visit_ips', '{}', 'the ip list that do not allow view any page. You may deny yourself, be careful!');
INSERT INTO `OnlineJudge`.`options` (`id`, `created_at`, `update_at`, `key`, `value`, `comment`) VALUES (5, DEFAULT, DEFAULT, 'allow_visit_ips', '{}', 'the ip list that can view page; if not empty, it will be checked first; You may deny yourself, be careful!');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineJudge`.`groups`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineJudge`;
INSERT INTO `OnlineJudge`.`groups` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`) VALUES (1, DEFAULT, DEFAULT, DEFAULT, 'admin');
INSERT INTO `OnlineJudge`.`groups` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`) VALUES (2, DEFAULT, DEFAULT, DEFAULT, 'teacher');
INSERT INTO `OnlineJudge`.`groups` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`) VALUES (3, DEFAULT, DEFAULT, DEFAULT, 'student');

COMMIT;

