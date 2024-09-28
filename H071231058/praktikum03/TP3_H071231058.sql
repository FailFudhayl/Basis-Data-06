-- Nama: Destin Kendenan
-- NIM : H071231058

-- nomor 1
INSERT INTO authors(nama, nationality)
VALUES ('Tere Liye', 'Indonesian'),
		 ('J.K. Rowling', 'British'),
		 ('Andrea Hinata', NULL);
		 
SELECT id FROM authors WHERE nama = 'Andrea Hinata';
SELECT id FROM authors WHERE nama = 'Tere Liye';
SELECT id FROM authors WHERE nama = 'J.K. Rowling';
		 
INSERT INTO books(isbn, title, author_id, published_year, genre, copies_available)
VALUES (704028970375, 'Ayah', 19, 2015, 'Fiction', 15),
		 (9780375704025, 'Bumi', 17, 2014, 'Fantasy', 5),
		 (8310371703024, 'Bulan', 17, 2015, 'Fantasy', 3),
		 (9780747532699, 'Harrry Potter and the Philosophers Stone', 18, 1997, NULL, 10),
		 (7210301703022, 'The Running Grave', 18, 2016, 'Fiction', 11);

INSERT INTO members(first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ('John', 'Doe', 'John.doe@example.com', NULL, '2023-04-29', NULL),
		 ('Alice', 'Johnson', 'alice.johnson@example.com', 1231231231, '2023-05-01', 'Standar'),
		 ('Bob', 'Williams', 'bob.williams@example.com', 3213214321, '2023-06-20', 'Premium');

SELECT id FROM members WHERE first_name = 'John';
SELECT id FROM members WHERE first_name = 'Bob';
SELECT id FROM members WHERE first_name = 'Alice';

SELECT id FROM books WHERE title = 'Harrry Potter and the Philosophers Stone';
SELECT id FROM books WHERE title = 'Ayah';
SELECT id FROM books WHERE title = 'The Running Grave';
SELECT id FROM books WHERE title = 'Bulan';
SELECT id FROM books WHERE title = 'Bumi';

INSERT INTO borrowings(member_id, book_id, borrow_date, return_date)
VALUES (10, 24, '2023-07-10', '2023-07-25'),
		 (12, 21, '2023-08-01', NULL),
		 (11, 25, '2023-09-06', '2023-09-09'),
		 (11, 23, '2023-09-08', NULL),
		 (12, 22, '2023-09-10', NULL);


-- nomor 2
SELECT * FROM borrowings WHERE return_date IS NULL;

UPDATE books
SET copies_available = copies_available - 1
WHERE id = 21;

UPDATE books
SET copies_available = copies_available - 1
WHERE id = 23;

UPDATE books
SET copies_available = copies_available - 1
WHERE id = 22;


-- nomor 3
SHOW CREATE TABLE borrowings;
ALTER TABLE borrowings
DROP FOREIGN KEY borrowings_ibfk_3;

ALTER  TABLE borrowings
ADD CONSTRAINT borrowings_ibfk_4 
FOREIGN KEY (member_id) REFERENCES members(id)
ON DELETE CASCADE ON UPDATE CASCADE 

DELETE FROM members
WHERE id = 11;

UPDATE members
SET membership_type = 'Standar' 
WHERE id = 12;

SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrowings;

