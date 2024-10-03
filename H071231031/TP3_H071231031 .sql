USE library;

DESCRIBE authors;

SHOW TABLES;

INSERT INTO authors (id, NAME, nationality) 
VALUES
(1, 'Tere liye', 'Indonesian'),
(2, 'J.K. Rowling', 'British'),
(3, 'Andrea Hirata', '');

SELECT* FROM authors;

DESCRIBE books;

INSERT INTO books (id, title, isbn, author_id, published_year, genre, copies_available) 
VALUES
(1, 'Ayah', '7040289780375', '3', '2015', 'Fiction', '15'),
(2, 'Bumi', '9780375704025', '1', '2014', 'Fantasy', '5'),
(3, 'Bulan', '8310371703024', '1', '2015', 'Fantasy', '3'),
(4, 'Harry Potter and The Philsopher\'s Stone', '9780747532699', '2', '1997', '', '10'),
(5, 'The Running Grave', '72103101703022', '2', '2016', 'Fiction', '11');

SELECT* FROM books;

DESCRIBE members;

INSERT INTO members (id, first_name, Last_name, email, phone_number, join_date, membership_type) 
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '', '2023-04-29', ''),
(2, 'Alice', 'Johnson', 'alice.johnson@example.com', '123123123', '2023-05-01', 'Standar'),
(3, 'Bob', 'Williams', 'bob.williams@example.com', '3213214321', '2023-06-20', 'Premium');

SELECT* FROM members;
DESCRIBE borrowings;

INSERT INTO borrowings (id, member_id , book_id, borrow_date, return_date)
VALUES
(1, '1', '4', '2023-07-10', '2023-07-25'),
(2, '3', '1', '2023-08-01', 'NULL'),
(3, '2', '5', '2023-09-06', '2023-09-09'),
(4, '2', '3', '2023-09-08', 'NULL'),
(5, '3', '2', '2023-09-10', 'NULL');

SELECT member_id FROM borrowings WHERE return_date = 'NULL';

UPDATE books 
SET copies_available = copies_available -1
WHERE id = '1' OR '3' OR '2';

SELECT* FROM books;

DELETE FROM books;

SELECT membership_type FROM members WHERE id = '3' OR 2;

UPDATE members 
SET membership_type = 'Standar'
WHERE id = 3;

DELETE FROM members
WHERE id = '2' AND membership_type ='Standar';

SHOW CREATE TABLE borrowings;

ALTER TABLE borrowings 
DROP FOREIGN KEY borrowings_ibfk_1;

ALTER TABLE borrowings 
ADD CONSTRAINT borrowings_ibfk_1
FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE;

SELECT* FROM books MEMBER, borrowings;

SELECT* FROM books;

DESCRIBE books;
INSERT INTO books (id, title, isbn, author_id, published_year, genre, copies_available)
VALUE
(6, 'Ibu', '6969696969', 3, 2023, 'Drama', 60);







