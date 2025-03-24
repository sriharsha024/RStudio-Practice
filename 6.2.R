
library(DBI)
library(RSQLite)

print("K. Sri Harsha Royal")
print("22BCE0893")

# Step 1: Create or Connect to SQLite Database
conn <- dbConnect(SQLite(), dbname = "sales_database.db")

# Step 2: Create a Table in the Database
dbExecute(conn, "DROP TABLE IF EXISTS sales;")
dbExecute(conn, "
    CREATE TABLE sales (
        Product_ID INTEGER PRIMARY KEY,
        Name TEXT,
        Units_Sold INTEGER,
        Price REAL
    );
")

# Step 3: Insert Sample Data
dbExecute(conn, "
    INSERT INTO sales (Product_ID, Name, Units_Sold, Price) VALUES
    (2001, 'Laptop', 150, 1200),
    (2002, 'Smartphone', 300, 800),
    (2003, 'Tablet', 100, 600),
    (2004, 'Smartwatch', 200, 300),
    (2005, 'Desktop', 75, 1000);
")

# Step 4: Perform SQL Queries

# i) Find all products where the units sold are greater than 150
query1 <- dbGetQuery(conn, "SELECT * FROM sales WHERE Units_Sold > 150;")
print("Products with Units Sold > 150:")
print(query1)

# ii) Select only the Name and Price columns
query2 <- dbGetQuery(conn, "SELECT Name, Price FROM sales;")
print("Product Name and Price:")
print(query2)

# iii) Count how many products have sold less than or equal to 100 units
query3 <- dbGetQuery(conn, "SELECT COUNT(*) AS Low_Sales_Count FROM sales WHERE Units_Sold <= 100;")
print("Count of Products with <= 100 Units Sold:")
print(query3)

# iv) Retrieve the Product ID and Name of the product with the highest price
query4 <- dbGetQuery(conn, "SELECT Product_ID, Name FROM sales ORDER BY Price DESC LIMIT 1;")
print("Product with the Highest Price:")
print(query4)

# v) Update the prices of all products by increasing them by 10% and display the updated prices
dbExecute(conn, "UPDATE sales SET Price = Price * 1.10;")
query5 <- dbGetQuery(conn, "SELECT * FROM sales;")
print("Updated Prices after 10% Increase:")
print(query5)

# Step 5: Close the Database Connection
dbDisconnect(conn)
