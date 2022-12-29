import csv
from google.cloud import storage
from google.cloud.storage import Blob
import mysql.connector

def save_queries(request):
    # Connect to the MySQL database
    conn = mysql.connector.connect(host='34.168.89.153',
                       user='root',
                       password='123456',
                       db='classicmodels')    
                       

    queries = [
        ('productlines', 'SELECT * FROM productlines'),
        ('customers', 'SELECT * FROM customers'),
        ('employees', 'SELECT * FROM employees'),
        ('orders', 'SELECT * FROM orders'),
        ('products', 'SELECT * FROM products'),
        ('payments', 'SELECT * FROM payments'),
        ('offices', 'SELECT * FROM offices')
    ]

    # Create a new Cloud Storage client
    client = storage.Client()

    # Get the bucket where you want to save the results
    bucket = client.bucket('westeros-1208')

    # Loop through the queries and execute each one
    for name, query in queries:
        cursor = conn.cursor()
        cursor.execute(query)
        results = cursor.fetchall()

        # Create a new blob in the bucket to store the query results
        blob = Blob('{}.csv'.format(name), bucket)

        # Open the blob for writing
        with blob.open('w') as file:
            writer = csv.writer(file)

            # Loop through the results and write them to the CSV file
            for result in results:
                writer.writerow(result)
    # Close the database connection
    conn.close()
    return 'Query results saved to Cloud Storage as CSV files with table names.'