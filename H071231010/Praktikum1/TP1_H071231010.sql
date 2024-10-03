CREATE DATABASE library;

USE library;

CREATE TABLE authors(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL
);

CREATE TABLE books(
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn VARCHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY (author_id) REFERENCES authors(id)
);

ALTER TABLE authors
ADD nationality VARCHAR(50);

ALTER TABLE books
ADD CONSTRAINT UNIQUE (isbn);  

DESCRIBE authors;
DESCRIBE books;
SHOW TABLES;

#5
#modifikasi table authors
ALTER TABLE authors
MODIFY COLUMN nationality VARCHAR(50) NOT NULL;

#modifikasi table books
ALTER TABLE books
MODIFY COLUMN isbn CHAR(13) UNIQUE NOT NULL;

ALTER TABLE books
MODIFY COLUMN author_id INT NOT NULL;

ALTER TABLE books
MODIFY COLUMN title VARCHAR(150) NOT NULL;

ALTER TABLE books
ADD published_year YEAR NOT NULL;

ALTER TABLE books
ADD genre VARCHAR(50) NOT NULL;

ALTER TABLE books
ADD copies_available INT NOT NULL;


#table members 
CREATE TABLE members (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL
)

DESCRIBE members;

#table borrowings
CREATE TABLE borrowings (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	member_id INT NOT NULL,
	book_id INT NOT NULL,
	borrow_date DATE NOT NULL,
	return_date DATE,
	FOREIGN KEY (member_id) REFERENCES members(id),
	FOREIGN KEY (book_id) REFERENCES books(id)
)
DESCRIBE borrowings;

 
