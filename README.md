# Library Management System - SQL Project
### Description
This project is a SQL-based Library Management System that helps manage information related to books, authors, publishers, library branches, borrowers, and book loans. The system is built using SQL (MySQL syntax) and includes schema creation, data querying, and relational integrity through foreign key constraints.

### Database Structure
Database: Library
The system comprises the following tables:

tbl_publisher

Stores information about publishers.

Primary Key: publisher_PublisherName

tbl_book

Stores book details and links each book to a publisher.

Primary Key: book_BookID

Foreign Key: book_PublisherName → tbl_publisher

tbl_book_authors

Manages the authors of books.

Primary Key: book_authors_AuthorID (auto-increment)

Foreign Key: book_authors_BookID → tbl_book

tbl_library_branch

Contains data about various library branches.

Primary Key: library_branch_BranchID (auto-increment)

tbl_book_copies

Tracks the number of copies of each book available at different branches.

Primary Key: book_copies_CopiesID (auto-increment)

Foreign Keys: book_copies_BookID → tbl_book, book_copies_BranchID → tbl_library_branch

tbl_borrower

Stores borrower information.

Primary Key: borrower_CardNo

tbl_book_loans

Logs borrowing activities including due dates and borrowers.

Primary Key: book_loans_LoansID (auto-increment)

Foreign Keys: book_loans_BookID, book_loans_BranchID, book_loans_CardNo


### Conclusion
The Library Management System implemented in SQL provides a robust foundation for managing essential library operations such as tracking books, authors, borrowers, and loan transactions. By using a relational database model with properly defined foreign key constraints and normalized tables, the system ensures data consistency and integrity.

The project demonstrates practical SQL skills including:

Database design and schema creation

Use of JOINs for relational data retrieval

Aggregate functions and grouping

Filtering using HAVING and subqueries

This system can be expanded in the future to include features like book reservations, overdue notifications, fines, and an administrative interface. Overall, it serves as a strong example of how SQL can be effectively used to handle real-world data management needs in a library environment.

