create database Library;
use Library;

-- Table: tbl_publisher
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);

-- Table: tbl_book
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);

-- Table: tbl_book_authors
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);

-- Table: tbl_library_branch
CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress TEXT
);

-- Table: tbl_book_copies
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
);

-- Table: tbl_borrower
CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);

-- Table: tbl_book_loans
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);

-- print all the tables.
select * from tbl_publisher;
select * from tbl_book;
select * from tbl_book_authors;
select * from tbl_library_branch;
select * from tbl_book_copies;
select * from tbl_borrower;
select * from tbl_book_loans;


-- Task Questions
-- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
select book.book_title,branch.library_branch_BranchName,sum(copy.book_copies_no_of_copies) as no_of_copies from tbl_book book
 inner join tbl_book_copies copy on book.book_BookID=copy.book_copies_BookID
inner join tbl_library_branch branch on copy.book_copies_BranchID=branch.library_branch_BranchID
group by book.book_title,branch.library_branch_BranchName
having book.book_title="The Lost Tribe" and branch.library_branch_BranchName ="Sharpstown";


-- How many copies of the book titled "The Lost Tribe" are owned by each library branch?
select book.book_Title,branch.library_branch_BranchName,sum(copy.book_copies_no_of_copies) as no_of_copies from tbl_book book
 inner join tbl_book_copies copy on book.book_BookID=copy.book_copies_BookID
inner join tbl_library_branch branch on copy.book_copies_BranchID=branch.library_branch_BranchID
group by branch.library_branch_BranchName,book.book_Title
having book.book_Title="The Lost Tribe";

-- Retrieve the names of all borrowers who do not have any books checked out.
select * from tbl_borrower;
select * from tbl_book_loans;

select borrower_BorrowerName from tbl_borrower
where borrower_BorrowerName not in (
select borrow.borrower_BorrowerName from tbl_borrower borrow 
inner join tbl_book_loans loans on borrow.borrower_CardNo=loans.book_loans_CardNo);


-- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address.
select * from tbl_book_loans;
select * from tbl_borrower;
select * from tbl_library_branch;
select * from tbl_book;

select book.book_Title,borrow.borrower_BorrowerName,borrow.borrower_BorrowerAddress from tbl_book book 
inner join tbl_book_loans loan on book.book_BookID=loan.book_loans_BookID
inner join tbl_library_branch branch on loan.book_loans_BranchID=branch.library_branch_BranchID
inner join tbl_borrower borrow on loan.book_loans_CardNo=borrow.borrower_CardNo
where branch.library_branch_BranchName="Sharpstown" and loan.book_loans_DueDate="2018-03-02";


-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
select * from tbl_library_branch;
select * from tbl_book_loans;
select * from tbl_book_copies;

select branch.library_branch_BranchName,count(loan.book_loans_BookID) from tbl_library_branch branch 
left join tbl_book_loans loan on branch.library_branch_BranchID=loan.book_loans_BranchID
group by branch.library_branch_BranchName;


-- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
select borrow.borrower_BorrowerName,borrow.borrower_BorrowerAddress,count(*) from tbl_borrower borrow 
inner join tbl_book_loans loan on borrow.borrower_CardNo=loan.book_loans_CardNO
group by borrow.borrower_BorrowerName,borrow.borrower_BorrowerAddress
having count(*)>5;


-- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
select book.book_Title,sum(copy.book_copies_no_of_copies) from tbl_book_authors author
 inner join tbl_book book on author.book_authors_BookID=book.book_BookID
inner join tbl_book_copies copy on book.book_BookID=copy.book_copies_BookID
inner join tbl_library_branch branch on copy.book_copies_BranchID=branch.library_branch_BranchID
where author.book_authors_AuthorName="Stephen King" and branch.library_branch_BranchName="Central"
group by book.book_Title;
