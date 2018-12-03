CREATE DATABASE  `task_managment`;

use `task_managment`;

#----------permition----------
CREATE TABLE IF NOT EXISTS `task_managment`.`permition` (
  `permition_id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(15) NOT NULL UNIQUE,
  PRIMARY KEY (`permition_id`)
 )ENGINE=INNODB;

#----------statuses----------
CREATE TABLE IF NOT EXISTS `task_managment`.`statuses` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(15) NOT NULL UNIQUE,
  PRIMARY KEY (`status_id`)
 )ENGINE = InnoDB;

#----------users----------
CREATE TABLE IF NOT EXISTS `task_managment`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(15) NOT NULL ,
  `user_name` NVARCHAR(10) NOT NULL UNIQUE,
  `password` NVARCHAR(64) NOT NULL,
  `email` NVARCHAR(30) NOT NULL,
  `status` INT NULL,
  `manager` INT NULL,
  `is_active` INT NULL default 1,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_status`
    FOREIGN KEY (`status`)
    REFERENCES `task_managment`.`statuses` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manager`
    FOREIGN KEY (`manager`)
    REFERENCES `task_managment`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#----------projects----------
CREATE TABLE IF NOT EXISTS `task_managment`.`projects` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(15)NOT NULL UNIQUE,
  `customer` NVARCHAR(15) NOT NULL,
  `team_leader` INT NOT NULL,
  `develop_houres` INT NOT NULL,
  `qa_houres` INT NOT NULL,
  `ui_ux_houres` INT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `is_complete` INT DEFAULT 0 NULL,
  PRIMARY KEY (`project_id`),
  CONSTRAINT `check_end_date` CHECK (end_date>start_date),
  CONSTRAINT `fk_team_leader`
    FOREIGN KEY (`team_leader`)
    REFERENCES `task_managment`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )ENGINE = InnoDB;

#----------status permition----------
CREATE TABLE IF NOT EXISTS `task_managment`.`status_permition` (
  `status_permition_id` INT NOT NULL AUTO_INCREMENT,
  `status_id` INT NOT NULL,
  `permition_id` INT NOT NULL,
  PRIMARY KEY (`status_permition_id`),
  CONSTRAINT `fk_statuses`
    FOREIGN KEY (`status_id`)
    REFERENCES `task_managment`.`statuses` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permition`
    FOREIGN KEY (`permition_id`)
    REFERENCES `task_managment`.`permition` (`permition_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#----------daily presence----------
CREATE TABLE IF NOT EXISTS `task_managment`.`daily_presence` (
  `daily_presence_id` INT NOT NULL AUTO_INCREMENT,
  `user_project_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `start` TIME NULL,
  `end` TIME NULL,
  PRIMARY KEY (`daily_presence_id`),
  CONSTRAINT `fk_project_user`
    FOREIGN KEY (`user_project_id`)
    REFERENCES `task_managment`.`user_projects` (`user_project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#----------user projects----------
CREATE TABLE IF NOT EXISTS `task_managment`.`user_projects` (
  `user_project_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `allocated_hours` FLOAT NULL,
  PRIMARY KEY (`user_project_id`),
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `task_managment`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `task_managment`.`projects` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#----------insert----------
INSERT INTO task_managment.projects VALUES (0,'ProjectA','cA',1,300,250,100,'02/02/2018 00:00:00','07/07/2018 00:00:00');
INSERT INTO task_managment.projects VALUES (1,'ProjectB','cB',101,300,250,100,'02/05/2018 00:00:00','07/07/2020 00:00:00');

INSERT INTO users (user_id,name,user_name,password,email,status,manager) values (37,'worker','worker','68487dc295052aa79c530e283ce698b8c6bb1b42ff0944252e1910dbecdc5425','worker@gmail.com',3,101);
INSERT INTO users (user_id,name,user_name,password,email,status) values (1,'team','team','4cc8f4d609b717356701c57a03e737e5ac8fe885da8c7163d3de47e01849c635','teamleader@gmail.com',2);
INSERT INTO users (user_id,name,user_name,password,email,status) values (0,'tamar','tamar','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92"','tamar@gmail.com',1);
INSERT INTO users (user_id,name,user_name,password,email,status) values (5,'fff','fff','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92"','fffff@gmail.com',1);
INSERT INTO users (user_id,name,user_name,password,email,status) values (50,'manager','manager','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','manager@gmail.com',1);
INSERT INTO users (user_id,name,user_name,password,email,status) values (51,'manag','manag','68487dc295052aa79c530e283ce698b8c6bb1b42ff0944252e1910dbecdc5425','manager@gmail.com',1);
INSERT INTO users (user_id,name,user_name,password,email,status) values (40,'mmm','mmm','68487dc295052aa79c530e283ce698b8c6bb1b42ff0944252e1910dbecdc5425','mmmmmm@gmail.com',1);

INSERT INTO users (user_id,name,user_name,password,email,status,manager) values (39,'workerTw','workerTw','68487dc295052aa79c530e283ce698b8c6bb1b42ff0944252e1910dbecdc5425','worker@gmail.com',3,1);
INSERT INTO user_projects(user_id,project_id,allocated_hours) values (3,1,30);

INSERT INTO statuses ( name) values ('manager');
INSERT INTO statuses ( name) values ('teamLeader');
INSERT INTO statuses ( name) values ('developer');
INSERT INTO statuses ( name) values ('QA');
INSERT INTO statuses ( name) values ('UIUX');

#------------select------------
select * from users;
select * from projects;
select * from user_projects;
select * from daily_presence;
select * from statuses;

#----------update tables----------
ALTER TABLE `task_managment`.`users`
	ADD is_active INT DEFAULT 1 NULL;
    
delete from `task_managment`.`users` where user_name='tamar';

delete from `task_managment`.`daily_presence` where daily_presence_id=59;
 ALTER TABLE `task_managment`.`projects`
	ADD is_complete INT DEFAULT 0 NULL;        
         
         
         