# Overview

The software I wrote is a Python program that integrates with a SQL Relational Database using SQLite3. The program creates two tables, one for customer information and one for orders, and allows users to add data to these tables as well as retrieve data using SQL queries.

To use the program, users can run the Python script and input customer and order data using the command line interface. The program validates the data input and adds it to the appropriate table in the SQLite database. Users can also retrieve data from the tables using SQL queries.

The purpose of writing this software was to further my learning as a software engineer by practicing working with SQL relational databases using Python. By creating a program that integrates with a database, I was able to gain hands-on experience with SQL syntax and learn how to use Python's SQLite3 library to interact with databases. Additionally, this project allowed me to practice data validation techniques to ensure the integrity of the data in the database. Overall, this project helped me build my skills in database programming and data validation, which are valuable skills for any software engineer.

[Software Demo Video](https://youtu.be/3zKvykSKdJc)

# Relational Database

The database holds information about the customer information of an online business, and the orders they made.

The 'customers' table has the following columns:
'id': a unique identifier for each customer, which is automatically generated primary key.
'first_name': the customer's first name.
'last_name': the customer's last name.
'birthday': the customer's birthday in the format of YYYY-MM-DD.
'address': the customer's street address.
'email': the customer's email address.

The orders table has the following columns:

'id': same concept as the 'id' in the 'customers' table.
'order_date': the date the order was placed in the format of YYYY-MM-DD.
'order_status': the status of the order, which can be one of the following values: Pending, Processing, Shipped, Delivered, or Cancelled.
'order_price': the total price of the order.
'customer_id': the ID of the customer who placed the order, which references the id column of the customers table.

The relationship between the 'customers' and 'orders' table is a one to many relationship. Which means one customer could have multipe orders but each order can only be associated with one customer.

# Development Environment

Python: I used Python as the primary programming language for the software.

SQLite3: I used SQLite3 as the relational database management system for the software. SQLite3 is a lightweight, serverless, and self-contained database engine that is easy to set up and use.

MySQL Workbench: I used MySQLWorkbench to creat and diagram the database.

# Useful Websites

- [YouTube](https://www.youtube.com/watch?v=girsuXz0yA8)
- [w3schools](https://www.w3schools.com/sql/)
- [freecodecamp](https://www.freecodecamp.org/news/connect-python-with-sql/)

# Future Work

- Item 1 Data validation check.
- Item 2 Add user interface.
- Item 3 Add more featuressuch as the ability to update customer and order information, generate reports, and analyze data.
