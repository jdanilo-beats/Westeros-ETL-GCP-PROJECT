from google.cloud import bigquery
from datetime import datetime

TABLES = ['customers', 'employees', 'offices',
          'orders', 'orderdetails', 'payments', 'productlines', 'products']

SCHEMAS = {
    'customers': [
        bigquery.SchemaField("customerNumber", "INT64"),
        bigquery.SchemaField("customerName", "STRING"),
        bigquery.SchemaField("contactLastName", "STRING"),
        bigquery.SchemaField("contactFirstName", "STRING"),
        bigquery.SchemaField("phone", "STRING"),
        bigquery.SchemaField("addressLine1", "STRING"),
        bigquery.SchemaField("addressLine2", "STRING"),
        bigquery.SchemaField("city", "STRING"),
        bigquery.SchemaField("state", "STRING"),
        bigquery.SchemaField("postalCode", "STRING"),
        bigquery.SchemaField("country", "STRING"),
        bigquery.SchemaField("salesRepEmployeeNumber", "STRING"),
        bigquery.SchemaField("creditLimit", "FLOAT64"),
    ],
    'employees': [
        bigquery.SchemaField("employeeNumber", "INT64"),
        bigquery.SchemaField("lastName", "STRING"),
        bigquery.SchemaField("firstName", "STRING"),
        bigquery.SchemaField("extension", "STRING"),
        bigquery.SchemaField("email", "STRING"),
        bigquery.SchemaField("officeCode", "STRING"),
        bigquery.SchemaField("reportsTo", "STRING"),
        bigquery.SchemaField("jobTitle", "STRING"),
    ],
    'offices': [
        bigquery.SchemaField("officeCode", "INT64"),
        bigquery.SchemaField("city", "STRING"),
        bigquery.SchemaField("phone", "STRING"),
        bigquery.SchemaField("addressLine1", "STRING"),
        bigquery.SchemaField("addressLine2", "STRING"),
        bigquery.SchemaField("state", "STRING"),
        bigquery.SchemaField("country", "STRING"),
        bigquery.SchemaField("postalCode", "STRING"),
        bigquery.SchemaField("territory", "STRING"),
    ],
    'orders': [
        bigquery.SchemaField("orderNumber", "INT64"),
        bigquery.SchemaField("orderDate", "DATE"),
        bigquery.SchemaField("requiredDate", "DATE"),
        bigquery.SchemaField("shippedDate", "DATE"),
        bigquery.SchemaField("status", "STRING"),
        bigquery.SchemaField("comments", "STRING"),
        bigquery.SchemaField("customerNumber", "INT64"),
    ],
    'orderdetails': [
        bigquery.SchemaField("orderNumber", "INT64"),
        bigquery.SchemaField("productCode", "STRING"),
        bigquery.SchemaField("quantityOrdered", "INT64"),
        bigquery.SchemaField("priceEach", "FLOAT64"),
        bigquery.SchemaField("orderLineNumber", "STRING"),
    ],
    'payments': [
        bigquery.SchemaField("customerNumber", "INT64"),
        bigquery.SchemaField("checkNumber", "STRING"),
        bigquery.SchemaField("paymentDate", "DATE"),
        bigquery.SchemaField("amount", "FLOAT64"),
    ],
    'productlines': [
        bigquery.SchemaField("productLine", "STRING"),
        bigquery.SchemaField("textDescription", "STRING"),
        bigquery.SchemaField("htmlDescription", "STRING"),
        bigquery.SchemaField("image", "STRING"),
    ],
    'products': [
        bigquery.SchemaField("productCode", "STRING"),
        bigquery.SchemaField("productName", "STRING"),
        bigquery.SchemaField("productLine", "STRING"),
        bigquery.SchemaField("productScale", "STRING"),
        bigquery.SchemaField("productVendor", "STRING"),
        bigquery.SchemaField("productDescription", "STRING"),
        bigquery.SchemaField("quantityInStock", "INT64"),
        bigquery.SchemaField("buyPrice", "FLOAT64"),
        bigquery.SchemaField("MSRP", "FLOAT64"),
    ]
}


def create_bigquery_tables(request):

    client = bigquery.Client()
    for table in TABLES:
        print(f"Start process for {table}")
        job_config = bigquery.LoadJobConfig(
            schema=SCHEMAS[table],
            skip_leading_rows=1,
            # The source format defaults to CSV, so the line below is optional.
            source_format=bigquery.SourceFormat.CSV,
            
            write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
            field_delimiter="," if table != 'orderdetails' and table != 'products' else f";",
        )

        table_id = f"westeros-jdanilo.westeros_raw_data_layer.{table}"
        #today = datetime.now().strftime('%Y-%m-%d')
        file_name = f"{table}.csv" if table != 'orderdetails' else f"{table}.csv"
        uri = f"gs://westeros-1208/{file_name}"

        load_job = client.load_table_from_uri(
            uri, table_id, job_config=job_config
        )

        load_job.result()  # Waits for the job to complete.

        destination_table = client.get_table(table_id)

        print(f"Loaded {destination_table.num_rows} rows from {table}")
    return f'check the results in the logs'
