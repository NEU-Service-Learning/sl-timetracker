-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema TimeTracker
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TimeTracker
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TimeTracker` DEFAULT CHARACTER SET utf8 ;
USE `TimeTracker` ;

-- -----------------------------------------------------
-- Table `TimeTracker`.`Instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Instructor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `pwd` VARCHAR(45) NOT NULL,
  `role` TINYINT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`College`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`College` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `college_id`
    FOREIGN KEY (`id`)
    REFERENCES `TimeTracker`.`College` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `course_number` VARCHAR(8) NULL,
  `name` VARCHAR(45) NOT NULL,
  `instructor_id` INT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `instructor_id_idx` (`instructor_id` ASC),
  INDEX `department_id_idx` (`department_id` ASC),
  CONSTRAINT `instructor_id`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `TimeTracker`.`Instructor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `department_id`
    FOREIGN KEY (`department_id`)
    REFERENCES `TimeTracker`.`Department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Student` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `pwd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Community_Partner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Community_Partner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Project` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `community_partner_id` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `description` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `community_partner_id_idx` (`community_partner_id` ASC),
  CONSTRAINT `community_partner_id`
    FOREIGN KEY (`community_partner_id`)
    REFERENCES `TimeTracker`.`Community_Partner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Project_Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Project_Location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `location` POINT NULL,
  INDEX `project_id_idx` (`project_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `project_id`
    FOREIGN KEY (`project_id`)
    REFERENCES `TimeTracker`.`Project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Record_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Record_Category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Record` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `location_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `comments` MEDIUMTEXT NULL,
  `extra_field` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `class_id_idx` (`course_id` ASC),
  INDEX `project_id_idx` (`project_id` ASC),
  INDEX `location_id_idx` (`location_id` ASC),
  INDEX `category_id_idx` (`category_id` ASC),
  CONSTRAINT `student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `TimeTracker`.`Student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `TimeTracker`.`Course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `project_id`
    FOREIGN KEY (`project_id`)
    REFERENCES `TimeTracker`.`Project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location_id`
    FOREIGN KEY (`location_id`)
    REFERENCES `TimeTracker`.`Project_Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `TimeTracker`.`Record_Category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Administrator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Administrator` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `pwd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TimeTracker`.`Enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TimeTracker`.`Enrollment` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `current_class` TINYINT(1) NULL,
  PRIMARY KEY (`student_id`, `course_id`),
  INDEX `course_id_idx` (`course_id` ASC),
  CONSTRAINT `student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `TimeTracker`.`Student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `TimeTracker`.`Course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
