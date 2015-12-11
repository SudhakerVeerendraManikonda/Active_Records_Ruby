drop table if exists workers;
drop table if exists work_orders;
drop table if exists statuses;

create table workers(
  id INTEGER primary key,
  first_name nvarchar(50) not null,
  last_name  nvarchar(50) not null
);

create table statuses(
  id INTEGER primary key not null,
  status_description  nvarchar(50) not null
);

INSERT INTO workers VALUES(null,'William','Smith');
INSERT INTO workers VALUES(null,'John','Morgan');

INSERT INTO statuses VALUES(null,'Created');
INSERT INTO statuses VALUES(null,'In Progress');
INSERT INTO statuses VALUES(null,'Review');
INSERT INTO statuses VALUES(null,'Completed');

create table work_orders(
  id INTEGER primary key not null,
  work_details  nvarchar(100) not null,
  date_of_creation datetime not null,
  status_id INTEGER not null ,
  last_update_date datetime not null,
  worker_id INTEGER,
  FOREIGN KEY(status_id) REFERENCES statuses(id) ,
  FOREIGN KEY(worker_id) REFERENCES workers(id)
);

INSERT INTO work_orders VALUES(null,'Assignment','2013-07-23 00:29:52 UTC',1,'2013-07-23 00:29:52 UTC',1);



