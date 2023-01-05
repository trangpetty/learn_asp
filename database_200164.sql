create database THICK

use THICK
create table users(
	id int IDENTITY(1,1) not null primary key,
	email varchar(255) unique not null,
	name varchar(255) not null,
	password varchar(255) not null,
	role int not null default 0
)

create table books(
	id int IDENTITY(1,1) not null primary key,
	description varchar(255) not null,
	author varchar(255) not null,
	quanity int not null,
	user_id int FOREIGN KEY REFERENCES users(id)
)

create table received_notes(
	id int IDENTITY(1,1) not null primary key,
	book_id int FOREIGN KEY REFERENCES books(id),
	quanity int not null,
	user_id int FOREIGN KEY REFERENCES users(id),
	created_date date default getdate()
)

create table delivery_notes(
	id int IDENTITY(1,1) not null primary key,
	book_id int FOREIGN KEY REFERENCES books(id),
	quanity int not null,
	user_id int FOREIGN KEY REFERENCES users(id),
	created_date date default getdate()
)

insert into users(email,name,password,role) values
('trang200164@nuce.edu.vn','trangle','22072001',1),
('trangpetty22072001@gmail.com','letrang','220720001',0);
