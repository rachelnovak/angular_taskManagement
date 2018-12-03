use TaskManagment;

create database TaskManagment;

CREATE table user(
 id int primary KEY	auto_increment,
 _name nvarchar(15) not null ,
 email nvarchar(25) not null,
 user_name nvarchar(10) not null unique,
 _password nvarchar(10) not null,
 status_id int not null, 
 FOREIGN KEY (`status_id`) REFERENCES `_status`(`status_id`)
                      ON DELETE CASCADE
);

create table _status(
status_id int primary key auto_increment ,
status_name nvarchar(15) not null
);

create table daily_presence(
id int primary key auto_increment ,
user_id int not null,
start_time datetime not null,
end_time  datetime not null
);

create table user_project(
id int primary key auto_increment ,
user_id int not null,
project_id int not null,
hours int not null,
FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
                      ON DELETE CASCADE,
 FOREIGN KEY (`project_id`) REFERENCES `project`(`id`)
                      ON DELETE CASCADE
);

create table project(
id int primary key auto_increment ,
_name int not null,
costumer_name nvarchar(15) not null,
team_leader_id int not null,
develop_houres int not null, 
UI_UX_houres int not null,
QA_houres int not null, 
start_date date not null, 
end_date date not null
);

create table permition(
id int primary key auto_increment,
_name nvarchar(15) not null
);

create table user_permition(
id int primary key auto_increment,
user_id int not null,
premition_id int not null,
FOREIGN KEY (`user_id`) REFERENCES `user`(`id`)
                      ON DELETE CASCADE,
 FOREIGN KEY (`premition_id`) REFERENCES `permition`(`id`)
                      ON DELETE CASCADE
);

DROP TABLE worker_project ;

ALTER TABLE worker_project CHANGE worker_id user_id int;
update  user set status_id=1 where user_name='Tamar';
ALTER TABLE daily_presence
MODIFY worker_id int;
select * from _status
ALTER TABLE worker
ADD imageUrl nvarchar(50);
insert into _status ( _name) values ('manager');
insert into _status ( _name) values ('teamLeader');
insert into _status ( _name) values ('worker');
insert into taskmanagment.user (_name,email,user_name,_password,status_id,is_active) values(_name='shaul',
                            email='sh@gmail.com' ,user_name='shauli',_password='1111111',status_id=2 
                           ,is_active=1)

ALTER TABLE user CHANGE COLUMN is_active is_active bool NOT NULL DEFAULT 1;