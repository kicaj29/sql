--https://www.sqlshack.com/the-difference-between-cross-apply-and-outer-apply-in-sql-server/
CREATE TABLE Author
(
    id INT PRIMARY KEY,
    author_name VARCHAR(50) NOT NULL    
)

CREATE TABLE Book
(
    id INT PRIMARY KEY,
    book_name VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    author_id INT NOT NULL
 )

INSERT INTO Author VALUES
(1, 'Author1'),
(2, 'Author2'),
(3, 'Author3'),
(4, 'Author4'),
(5, 'Author5'),
(6, 'Author6'),
(7, 'Author7')

INSERT INTO Book VALUES
(1, 'Book1',500, 1),
(2, 'Book2', 300 ,2),
(3, 'Book3',700, 1),
(4, 'Book4',400, 3),
(5, 'Book5',650, 5),
(6, 'Book6',400, 3)

SELECT A.author_name, B.id, B.book_name, B.price
FROM Author A
INNER JOIN Book B
ON A.id = B.author_id

SELECT A.author_name, B.id, B.book_name, B.price
FROM Author A
LEFT JOIN Book B
ON A.id = B.author_id

CREATE FUNCTION fnGetBooksByAuthorId(@AuthorId int)
RETURNS TABLE
AS
RETURN
( 
SELECT * FROM Book
WHERE author_id = @AuthorId
)

SELECT * FROM fnGetBooksByAuthorId(3)

--ERROR: The multi-part identifier "A.Id" could not be bound.
SELECT A.author_name, B.id, B.book_name, B.price
FROM Author A
INNER JOIN fnGetBooksByAuthorId(A.Id) B
ON A.id = B.author_id

SELECT A.author_name, B.id, B.book_name, B.price
FROM Author A
CROSS APPLY fnGetBooksByAuthorId(A.Id) B

SELECT A.author_name, B.id, B.book_name, B.price
FROM Author A
OUTER APPLY fnGetBooksByAuthorId(A.Id) B