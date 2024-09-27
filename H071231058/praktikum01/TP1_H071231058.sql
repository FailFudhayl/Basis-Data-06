-- NO.1
CREATE DATABASE library;
USE library;

CREATE TABLE authors(
id INT PRIMARY KEY AUTO_INCREMENT,
nama VARCHAR(100) NOT NULL 
)

CREATE TABLE books(
id INT PRIMARY KEY AUTO_INCREMENT,
isbn CHAR(13),
title VARCHAR(100) NOT NULL,
author_id INT,
FOREIGN KEY (author_id) REFERENCES authors(id)
)

-- NO.2
ALTER TABLE authors
ADD nationality VARCHAR(50)

-- NO.3
ALTER TABLE books
MODIFY isbn CHAR(13) UNIQUE 

-- NO.4
SHOW TABLES;
DESCRIBE authors;
DESCRIBE books;

-- NO.5
ALTER TABLE authors
MODIFY nationality VARCHAR(50) NOT NULL 

ALTER TABLE books
MODIFY title VARCHAR(150) NOT NULL,
MODIFY isbn CHAR(13) UNIQUE NOT NULL,
MODIFY author_id INT NOT NULL,
ADD published_year YEAR NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INT NOT NULL 

CREATE TABLE members(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone_number CHAR(10),
join_date DATE NOT NULL,
membership_type VARCHAR(50) NOT NULL 
)

CREATE TABLE borrowings(
id INT PRIMARY KEY AUTO_INCREMENT,
member_id INT NOT NULL,
FOREIGN KEY (member_id) REFERENCES members(id),
book_id INT NOT NULL,
FOREIGN KEY (book_id) REFERENCES books(id),
borrow_date DATE NOT NULL,
return_date DATE 
)

ALTER TABLE borrowings
MODIFY id INT AUTO_INCREMENT

ALTER TABLE members
MODIFY id INT AUTO_INCREMENT 