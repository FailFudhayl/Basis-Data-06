-- H071231027

-- Kevin Ardhana

-- No 1
CREATE DATABASE library;

USE library;

CREATE TABLE authors(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(100) NOT NULL
);

CREATE TABLE books(
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn VARCHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY(author_id)REFERENCES authors(id)   
);

-- NO 2
ALTER TABLE authors
ADD nationality VARCHAR(50);

-- NO 3
ALTER TABLE books
ADD UNIQUE(isbn);


 -- NO 4
DESCRIBE books;
DESCRIBE authors;

-- NO 5

CREATE TABLE members(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings(
	id INT PRIMARY KEY AUTO_INCREMENT,
	member_id INT NOT NULL,
	book_id INT NOT NULL,
	borrow_date DATE NOT NULL,
	return_date DATE, 
	FOREIGN KEY(member_id) REFERENCES members(id),
	FOREIGN KEY(book_id) REFERENCES books(id)
);

DESCRIBE members;
DESCRIBE borrowings;

ALTER TABLE books
ADD published_year YEAR NOT NULL;

ALTER TABLE books
ADD genre VARCHAR(50) NOT NULL;

ALTER TABLE books
ADD copies_available INT NOT NULL;

ALTER TABLE books
MODIFY isbn VARCHAR(13) UNIQUE NOT NULL;

ALTER TABLE books
MODIFY author_id INT NOT NULL; 

ALTER TABLE authors
MODIFY nationality VARCHAR(50) NOT NULL;

ALTER TABLE books
MODIFY title TEXT(100) NOT NULL;

-- DROP DATABASE library;

-- ALTER TABLE books
-- DROP title ;
 