import sqlite3

# Create a connection to the database
conn = sqlite3.connect('customer_orders.db')

# Create a cursor object
c = conn.cursor()

# Create a table for customer information if it doesn't exist already
c.execute('''CREATE TABLE IF NOT EXISTS customers
             (id INTEGER PRIMARY KEY,
              first_name TEXT,
              last_name TEXT,
              birthday TEXT,
              address TEXT,
              email TEXT)''')

# Create a table for orders if it doesn't exist already
c.execute('''CREATE TABLE IF NOT EXISTS orders
             (id INTEGER PRIMARY KEY,
              order_date TEXT,
              order_status TEXT,
              order_price REAL,
              customer_id INTEGER,
              FOREIGN KEY(customer_id) REFERENCES customers(id))''')

# Insert customer information into the table
c.execute("INSERT INTO customers (first_name, last_name, birthday, address, email) VALUES (?, ?, ?, ?, ?)",
          ('John', 'Doe', '1980-01-01', '123 Main St', 'johndoe@example.com'))
c.execute("INSERT INTO customers (first_name, last_name, birthday, address, email) VALUES (?, ?, ?, ?, ?)",
          ('Jane', 'Doe', '1985-03-15', '456 Elm St', 'janedoe@example.com'))
c.execute("INSERT INTO customers (first_name, last_name, birthday, address, email) VALUES (?, ?, ?, ?, ?)",
          ('Bob', 'Smith', '1975-07-22', '789 Oak St', 'bobsmith@example.com'))
c.execute("INSERT INTO customers (first_name, last_name, birthday, address, email) VALUES (?, ?, ?, ?, ?)",
          ('Sara', 'Johnson', '1992-09-05', '1010 Pine St', 'sarajohnson@example.com'))
c.execute("INSERT INTO customers (first_name, last_name, birthday, address, email) VALUES (?, ?, ?, ?, ?)",
          ('Tom', 'Jones', '1988-12-31', '111 Maple St', 'tomjones@example.com'))

# Insert orders into the table
c.execute("INSERT INTO orders (order_date, order_status, order_price, customer_id) VALUES (?, ?, ?, ?)",
          ('2023-05-06', 'Complete', 50.0, 1))
c.execute("INSERT INTO orders (order_date, order_status, order_price, customer_id) VALUES (?, ?, ?, ?)",
          ('2023-05-06', 'Pending', 100.0, 2))
c.execute("INSERT INTO orders (order_date, order_status, order_price, customer_id) VALUES (?, ?, ?, ?)",
          ('2023-05-07', 'Complete', 75.0, 3))
c.execute("INSERT INTO orders (order_date, order_status, order_price, customer_id) VALUES (?, ?, ?, ?)",
          ('2023-05-07', 'Complete', 150.0, 4))
c.execute("INSERT INTO orders (order_date, order_status, order_price, customer_id) VALUES (?, ?, ?, ?)",
          ('2023-05-08', 'Pending', 200.0, 5))

# Commit the changes and close the connection
conn.commit()
conn.close()


