CREATE TABLE Admin
(
 "id"   serial NOT NULL,
 name varchar(50) NOT NULL,
 "pass" varchar(50) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( "id" )
);


CREATE TABLE "user"
(
 user_id int NOT NULL,
 name    varchar(50) NOT NULL,
 phone   json NOT NULL,
 email   varchar(50) NOT NULL,
 "pass"    varchar(50) NOT NULL,
 access  varchar(50) NOT NULL,
 CONSTRAINT PK_2 PRIMARY KEY ( user_id )
);



CREATE TABLE dashboard
(
 dashboard_id   int NOT NULL,
 name           varchar(50) NOT NULL,
 members        json NOT NULL,
 financial_info varchar(50) NOT NULL,
 license        varchar(50) NOT NULL,
 possibilities  json NOT NULL,
 CONSTRAINT PK_3 PRIMARY KEY ( dashboard_id )
);



CREATE TABLE duty
(
 duty_id int NOT NULL,
 files   json NOT NULL,
 CONSTRAINT PK_4 PRIMARY KEY ( duty_id )
);


CREATE TABLE "file"
(
 file_id int NOT NULL,
 content varchar(50) NOT NULL,
 CONSTRAINT PK_5 PRIMARY KEY ( file_id )
);


CREATE TABLE message
(
 message_id int NOT NULL,
 content    varchar(50) NOT NULL,
 CONSTRAINT PK_6 PRIMARY KEY ( message_id )
);


CREATE TABLE minutes
(
 minutes_id int NOT NULL,
 content    varchar(50) NOT NULL,
 CONSTRAINT PK_7 PRIMARY KEY ( minutes_id )
);

CREATE TABLE project
(
 project_id  int NOT NULL,
 name        varchar(50) NOT NULL,
 members     json NOT NULL,
 photo       json NOT NULL,
 panel_color varchar(50) NOT NULL,
 CONSTRAINT PK_8 PRIMARY KEY ( project_id )
);

CREATE TABLE project_manager
(
 user_id int NOT NULL,
 CONSTRAINT PK_9 PRIMARY KEY ( user_id ),
 CONSTRAINT FK_6 FOREIGN KEY ( user_id ) REFERENCES "user" ( user_id )
);

CREATE INDEX FK_2 ON project_manager
(
 user_id
);


CREATE TABLE project_user
(
 user_id int NOT NULL,
 CONSTRAINT PK_10 PRIMARY KEY ( user_id ),
 CONSTRAINT FK_7 FOREIGN KEY ( user_id ) REFERENCES "user" ( user_id )
);

CREATE INDEX FK_1 ON project_user
(
 user_id
);

CREATE TABLE team_manager
(
 user_id int NOT NULL,
 CONSTRAINT PK_11 PRIMARY KEY ( user_id ),
 CONSTRAINT FK_5 FOREIGN KEY ( user_id ) REFERENCES "user" ( user_id )
);

CREATE INDEX FK_3 ON team_manager
(
 user_id
);

CREATE TABLE change_the_access_level
(
 user_id int NOT NULL,
 "id"      int NOT NULL,
 level   varchar(50) NOT NULL,
 CONSTRAINT PK_12 PRIMARY KEY ( user_id, "id" ),
 CONSTRAINT FK_26_7 FOREIGN KEY ( user_id ) REFERENCES "user" ( user_id ),
 CONSTRAINT FK_26_8 FOREIGN KEY ( "id" ) REFERENCES Admin ( "id" )
);

CREATE INDEX FK_2_1 ON change_the_access_level
(
 user_id
);

CREATE INDEX FK_4 ON change_the_access_level
(
 "id"
);


CREATE TABLE create_dashboard
(
 dashboard_id int NOT NULL,
 user_id      int NOT NULL,
 "date"         date NOT NULL,
 CONSTRAINT PK_13 PRIMARY KEY ( dashboard_id, user_id ),
 CONSTRAINT FK_26_3 FOREIGN KEY ( dashboard_id ) REFERENCES dashboard ( dashboard_id ),
 CONSTRAINT FK_26_4 FOREIGN KEY ( user_id ) REFERENCES team_manager ( user_id )
);

CREATE INDEX FK_7 ON create_dashboard
(
 dashboard_id
);

CREATE INDEX FK_8 ON create_dashboard
(
 user_id
);


CREATE TABLE create_project
(
 project_id int NOT NULL,
 user_id    int NOT NULL,
 "date"       date NOT NULL,
 CONSTRAINT PK_14 PRIMARY KEY ( project_id, user_id ),
 CONSTRAINT FK_26_2 FOREIGN KEY ( project_id ) REFERENCES project ( project_id ),
 CONSTRAINT FK_26_14 FOREIGN KEY ( user_id ) REFERENCES team_manager ( user_id )
);

CREATE INDEX FK_9 ON create_project
(
 project_id
);

CREATE INDEX FK_10 ON create_project
(
 user_id
);

CREATE TABLE cretae_duty
(
 user_id    int NOT NULL,
 duty_id    int NOT NULL,
 checklists json NOT NULL,
 "date"       date NOT NULL,
 CONSTRAINT PK_15 PRIMARY KEY ( user_id, duty_id ),
 CONSTRAINT FK_26_11 FOREIGN KEY ( user_id ) REFERENCES project_user ( user_id ),
 CONSTRAINT FK_26_17 FOREIGN KEY ( duty_id ) REFERENCES duty ( duty_id )
);

CREATE INDEX FK_2_2 ON cretae_duty
(
 user_id
);

CREATE INDEX FK_11 ON cretae_duty
(
 duty_id
);


CREATE TABLE cretae_minutes
(
 user_id    int NOT NULL,
 minutes_id int NOT NULL,
 CONSTRAINT PK_16 PRIMARY KEY ( user_id, minutes_id ),
 CONSTRAINT FK_26_15 FOREIGN KEY ( user_id ) REFERENCES project_manager ( user_id ),
 CONSTRAINT FK_26_19 FOREIGN KEY ( minutes_id ) REFERENCES minutes ( minutes_id )
);

CREATE INDEX FK_12 ON cretae_minutes
(
 user_id
);

CREATE INDEX FK_13 ON cretae_minutes
(
 minutes_id
);


CREATE TABLE file_upload
(
 file_id int NOT NULL,
 user_id int NOT NULL,
 CONSTRAINT PK_17 PRIMARY KEY ( file_id, user_id ),
 CONSTRAINT FK_26_1 FOREIGN KEY ( file_id ) REFERENCES "file" ( file_id ),
 CONSTRAINT FK_26_16 FOREIGN KEY ( user_id ) REFERENCES project_manager ( user_id )
);

CREATE INDEX FK_2_3 ON file_upload
(
 file_id
);

CREATE INDEX FK_14 ON file_upload
(
 user_id
);

CREATE TABLE "grouping"
(
 project_id_1 int NOT NULL,
 user_id      int NOT NULL,
 CONSTRAINT PK_18 PRIMARY KEY ( project_id_1, user_id ),
 CONSTRAINT FK_27 FOREIGN KEY ( project_id_1 ) REFERENCES project ( project_id ),
 CONSTRAINT FK_26_13 FOREIGN KEY ( user_id ) REFERENCES project_manager ( user_id )
);

CREATE INDEX FK_3_1 ON "grouping"
(
 project_id_1
);

CREATE INDEX FK_15 ON "grouping"
(
 user_id
);

CREATE TABLE invites
(
 user_id      int NOT NULL,
 user_id_1    int NOT NULL,
 dashboard_id int NOT NULL,
 "date"         date NOT NULL,
 status       varchar(50) NOT NULL,
 level        varchar(50) NOT NULL,
 CONSTRAINT PK_19 PRIMARY KEY ( user_id, user_id_1, dashboard_id ),
 CONSTRAINT FK_26_5 FOREIGN KEY ( user_id ) REFERENCES team_manager ( user_id ),
 CONSTRAINT FK_26_6 FOREIGN KEY ( user_id_1 ) REFERENCES "user" ( user_id ),
 CONSTRAINT FK_27_1 FOREIGN KEY ( dashboard_id ) REFERENCES dashboard ( dashboard_id )
);

CREATE INDEX FK_2_4 ON invites
(
 user_id
);

CREATE INDEX FK_3_3 ON invites
(
 user_id_1
);

CREATE INDEX FK_16 ON invites
(
 dashboard_id
);


CREATE TABLE place
(
 user_id    int NOT NULL,
 duty_id    int NOT NULL,
 message_id int NOT NULL,
 "date"       date NOT NULL,
 CONSTRAINT PK_20 PRIMARY KEY ( user_id, duty_id, message_id ),
 CONSTRAINT FK_26_12 FOREIGN KEY ( user_id ) REFERENCES project_user ( user_id ),
 CONSTRAINT FK_26_18 FOREIGN KEY ( duty_id ) REFERENCES duty ( duty_id ),
 CONSTRAINT FK_26 FOREIGN KEY ( message_id ) REFERENCES message ( message_id )
);

CREATE INDEX FK_17 ON place
(
 user_id
);

CREATE INDEX FK_18 ON place
(
 duty_id
);

CREATE INDEX FK_4_1 ON place
(
 message_id
);



CREATE TABLE sent
(
 user_id    int NOT NULL,
 message_id int NOT NULL,
 "date"       date NOT NULL,
 receivers  json NOT NULL,
 CONSTRAINT PK_21 PRIMARY KEY ( user_id, message_id ),
 CONSTRAINT FK_26_20 FOREIGN KEY ( user_id ) REFERENCES project_user ( user_id ),
 CONSTRAINT FK_26_21 FOREIGN KEY ( message_id ) REFERENCES message ( message_id )
);

CREATE INDEX FK_2_5 ON sent
(
 user_id
);

CREATE INDEX FK_3_4 ON sent
(
 message_id
);



CREATE TABLE signUp
(
 "id"      int NOT NULL,
 user_id int NOT NULL,
 "date"    date NOT NULL,
 CONSTRAINT PK_22 PRIMARY KEY ( "id", user_id ),
 CONSTRAINT FK_26_9 FOREIGN KEY ( "id" ) REFERENCES Admin ( "id" ),
 CONSTRAINT FK_26_10 FOREIGN KEY ( user_id ) REFERENCES "user" ( user_id )
);

CREATE INDEX FK_20 ON signUp
(
 "id"
);

CREATE INDEX FK_21 ON signUp
(
 user_id
);


