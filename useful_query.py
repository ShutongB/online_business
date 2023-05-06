import sqlite3

# query 1
# Retrieve all customer information

conn = sqlite3.connect('customer_orders.db')
c = conn.cursor()

c.execute("SELECT * FROM customers")

rows = c.fetchall()

for row in rows:
    print(row)

conn.close()

# query 2
#Retrieve customer information for a specific customer by ID


conn = sqlite3.connect('customer_orders.db')
c = conn.cursor()

c.execute("SELECT * FROM customers WHERE id=?", (1,))

row = c.fetchone()

print(row)

conn.close()

# query 3
# Retrieve orders with a specific order status


# conn = sqlite3.connect('customer_orders.db')
c = conn.cursor()

c.execute("SELECT * FROM orders WHERE order_status=?", ('Complete',))

rows = c.fetchall()

for row in rows:
    print(row)

conn.close()

# query 4
# Count the number of the total order
conn = sqlite3.connect('customer_orders.db')
c = conn.cursor()

c.execute("SELECT COUNT(*) FROM orders")

rows = c.fetchall()

for row in rows:
    print(row)

conn.close()

# query 5
# Find the average price of a all orders
conn = sqlite3.connect('customer_orders.db')
c = conn.cursor()

c.execute("SELECT avg(order_price) FROM orders")

rows = c.fetchall()

for row in rows:
    print(row)

conn.close()