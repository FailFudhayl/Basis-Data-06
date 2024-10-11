USE library ;

-- Nomor 1
INSERT INTO authors (NAME, Nationality)
VALUES ('Tere Liye', 'Indonesian'), ('J.K.Rowling', 'British'), ('Andrea Hirata',NULL );

INSERT INTO books (isbn, Title, Author_id,published_year, genre, copies_available)
VALUES ('7040289780375', 'Ayah', 3, 2015, 'Fiction', 15), ('9780375704025', 'Bumi', 1, 2014, 'Fantasy', 5), 
('8310371703024', 'Bulan', 1, 2015, 'Fantasy', 3), ('9780747532699', 'Harry Potter and the Philosophers Stone', 2, 1997, Null , 10), 
('7210301703022', 'The Running Grave', 2, 2016, 'Fiction', 11);

INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ('Jhon', 'Doe', 'John.doe@example.com', NULL, '2023-04-29', NULL), 
('Alice', 'Johnson', 'alice.johnson@example.com', '1231231231', '2023-05-01', 'Standar'), 
('Bob', 'Williams', 'bob.williams@example.com', '3213214321', '2023-06-20', 'Premium');

INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES (1, 9, '2023-07-10', '2023-07-25'), 
(3, 6, '2023-08-01', NULL), 
(2, 10, '2023-09-06', '2023-09-09'), 
(2, 8, '2023-09-08', NULL), 
(3, 7, '2023-09-10', NULL);

-- Nomor 2
UPDATE books 
SET copies_available = copies_available -1
WHERE id=1 OR id=3 OR id=2;

-- Nomor 3
UPDATE members
SET membership_type = 'Standar'
WHERE id=3;

DELETE FROM borrowings
WHERE member_id=2;

DELETE FROM members
WHERE id=2;

SHOW CREATE TABLE authors;
DESCRIBE authors;

SELECT*FROM authors;
SELECT*FROM books;
SELECT*FROM members;
SELECT*FROM borrowings;