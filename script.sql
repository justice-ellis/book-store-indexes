--|Advanced PostgreSQL
--|Justice-Nana.Ellis
--|Book Store Indexes

--Task 1 | SELECT statements to get familiar with the content of tables
SELECT * 
FROM customers
LIMIT 10;

SELECT * 
FROM orders
LIMIT 10;

SELECT * 
FROM books
LIMIT 10;

--Task 2 | SELECT statements to see the indexes already present
SELECT *
FROM pg_indexes
WHERE tablename = 'customers';

SELECT *
FROM pg_indexes
WHERE tablename = 'books';

SELECT *
FROM pg_indexes
WHERE tablename = 'orders';

--Task 3 | creating indexes for the appropriate columns
CREATE INDEX orders_customerid_idx
ON orders (customer_id);

CREATE INDEX orders_bookid_idx
ON orders (book_id);

--Task 4 | Checking the runtime of a SELECT query 
EXPLAIN ANALYZE
SELECT original_language, title, sales_in_millions
FROM books
WHERE original_language = 'French';

--Task 5 | Checking the size of the books table 
SELECT pg_size_pretty (pg_total_relation_size('books'));

/*Q6. Multi-column index*/
CREATE INDEX books_compound_idx
ON books (original_language, title, sales_in_millions);

--Task 7 | Checking the runtime of a SELECT query and the size of the table 
EXPLAIN ANALYZE
SELECT original_language, title, sales_in_millions
FROM books
WHERE original_language = 'French';

SELECT pg_size_pretty (pg_total_relation_size('books'));

--Task 8 | Deleting the index on the books table
DROP INDEX IF EXISTS books_compound_idx;

--Task 10 | Deleting the indexes on the orders table
DROP INDEX IF EXISTS orders_customerid_idx;

DROP INDEX IF EXISTS orders_bookid_idx;

--Task 9 | Checking the runtime of a copy function
SELECT NOW();
 
\COPY orders FROM 'orders_add.txt' DELIMITER ',' CSV HEADER;
 
SELECT NOW();

--Task 10 | Recreating the indexes on the orders table
CREATE INDEX orders_customerid_idx
ON orders (customer_id);

CREATE INDEX orders_bookid_idx
ON orders (book_id);

--Task 11 | Creating an index on the books table
CREATE INDEX customers_firstname_email_idx
ON customers (first_name, email_address);
