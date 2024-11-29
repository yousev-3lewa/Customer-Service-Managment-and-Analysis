create table customer(
customer_id int primary key,
first_name VARCHAR(50),
last_name VARCHAR(50),
gender varchar(50),
email varchar(100),
phone_number varchar(200)
);

create table transactions(
transaction_id int primary key,
transaction_date date,
amount int,
payment_method varchar(200),
customer_id int FOREIGN KEY REFERENCES customer(customer_id),
product_id int foreign key references products(movie_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    manufacturer VARCHAR(255),
    modele VARCHAR(50),
    price INT,
);

CREATE TABLE interactions (
    interaction_id INT PRIMARY KEY,
    interaction_date DATE,
    interaction_type VARCHAR(50),
    interaction_score INT,
    customer_id int FOREIGN KEY REFERENCES customer(customer_id),
);

select * from interactions
BULK INSERT Project.dbo.customer
FROM 'E:/Customer Data.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- Skip the header row if it exists
);

BULK INSERT Project.dbo.interactions
FROM 'E:/interaction_table.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- Skip the header row if it exists
);

BULK INSERT Project.dbo.Products
    FROM 'E:/product2.csv'
    WITH
    (
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        FIRSTROW= 2
    )
select * from transactions

truncate table transactions

BULK INSERT Project.dbo.transactions
FROM 'E:/transaction.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- Skip the header row if it exists
);




alter table transactions drop constraint product_id


ALTER TABLE transactions
ADD product_id int FOREIGN KEY (product_id) REFERENCES products(product_id);
