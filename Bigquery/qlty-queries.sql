create or replace table `westeros-jdanilo.westeros_qlty_data_layer.customers_qty` (
customerNumber int64,
customerName string,
contactLastName string,
contactFirstName string,
phone string,
addressLine1 string,
addressLine2 string,
city string,
state string,
postalCode string,
country string,
salesRepEmployeeNumber int64,
creditLimit float64
)

;
insert `westeros-jdanilo.westeros_qlty_data_layer.customers_qty`

select * from (
  select customerNumber,
customerName,
contactLastName,
contactFirstName,
phone,
addressLine1,
addressLine2,
city,
state,
postalCode,
country,
CAST(CAST(CASE WHEN salesRepEmployeeNumber IS NULL THEN '0.0'
        ELSE salesRepEmployeeNumber END AS FLOAT64) AS INT64) AS salesRepEmployeeNumber,
creditLimit
from `westeros-jdanilo.westeros_raw_data_layer.customers`
)
;



create or replace table `westeros-jdanilo.westeros_qlty_data_layer.employees_qty` (
  employeeNumber int64,
  lastName string,
  firstName string,
  extension string,
  email string,
  officeCode string,
  reportsTo string,
  jobTitle string
)

;
insert `westeros-jdanilo.westeros_qlty_data_layer.employees_qty`

select * from (
  SELECT employeeNumber,
CASE WHEN lastName IS NULL THEN ''
ELSE lastName END AS lastName,
CASE WHEN firstName IS NULL THEN ''
ELSE firstName END AS firstName,
extension,
CASE WHEN email LIKE '%@%' THEN email
ELSE '' END AS email,
CASE WHEN officeCode IS NULL THEN '0'
ELSE officeCode END AS officeCode,
CASE WHEN reportsTo IS NULL THEN '0.0'
ELSE reportsTo END AS reportsTo,
CASE WHEN jobTitle IS NULL THEN ''
ELSE jobTitle END AS jobTitle,
FROM `westeros-jdanilo.westeros_raw_data_layer.employees`
)
;


create or replace table `westeros-jdanilo.westeros_qlty_data_layer.offices_qty` (officeCode string, city string, phone string,addressLine1 string,addressLine2 string,state string,country string,postalCode string)

;
insert `westeros-jdanilo.westeros_qlty_data_layer.offices_qty`

select * from (
  SELECT CAST(officeCode as string) as officeCode,
CASE WHEN city IS NULL THEN ''
ELSE city END AS city,
CASE WHEN phone IS NULL THEN ''
ELSE phone END AS phone,
CASE WHEN addressLine1 IS NULL THEN ''
ELSE addressLine1 END AS addressLine1,
CASE WHEN addressLine2 IS NULL THEN ''
ELSE addressLine2 END AS addressLine2,
CASE WHEN state IS NULL THEN ''
ELSE state END AS state,
CASE WHEN country IS NULL THEN ''
ELSE country END AS country,
CASE WHEN postalCode IS NULL THEN ''
ELSE postalCode END AS postalCode
FROM `westeros-jdanilo.westeros_raw_data_layer.offices`
)
;



create or replace table `westeros-jdanilo.westeros_qlty_data_layer.orderdetails_qty` (orderNumber int64,
productCode string,
quantityOrdered int64,
priceEach float64,
orderLineNumber string)
;
insert `westeros-jdanilo.westeros_qlty_data_layer.orderdetails_qty`

select * from (
  select orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber from `westeros-jdanilo.westeros_raw_data_layer.orderdetails`
)
;


create or replace table `westeros-jdanilo.westeros_qlty_data_layer.orders_qty` (orderNumber int64,orderDate date,,requiredDate date,shippedDate date,status string,comments string,customerNumber int64)

;
insert `westeros-jdanilo.westeros_qlty_data_layer.orders_qty`

select * from (
  SELECT orderNumber,orderDate,requiredDate,
case when shippedDate is null then '1900-01-01'
else shippedDate end as shippedDate,
case when status is null then ''
else status end as status,
case when comments is null then ''
else comments end as comments,
customerNumber
FROM `westeros-jdanilo.westeros_raw_data_layer.orders` 
)
;


create or replace table `westeros-jdanilo.westeros_qlty_data_layer.payments_qty` (customerNumber int64,checkNumber string,paymentDate date,amount float64)

;
insert `westeros-jdanilo.westeros_qlty_data_layer.payments_qty`

select * from (
  SELECT CASE WHEN customerNumber IS NULL THEN 0 ELSE customerNumber END AS customerNumber,
CASE WHEN checkNumber IS NULL THEN '' ELSE checkNumber END AS checkNumber,
CASE WHEN paymentDate IS NULL THEN '1900-01-01' ELSE paymentDate END AS paymentDate,
CASE WHEN amount IS NULL THEN 0.0 ELSE amount END AS amount
FROM `westeros-jdanilo.westeros_raw_data_layer.payments` 
)
;




create or replace table `westeros-jdanilo.westeros_qlty_data_layer.products_qty` (
productCode string,
productName string,
productLine string,
productScale string,
productVendor string,
quantityInStock int64,
buyPrice float64,
MSRP float64)

;
insert `westeros-jdanilo.westeros_qlty_data_layer.products_qty`

select * from (
  select case when productCode is null then 'none' else productCode end as productCode, 
case when productName is null then 'none' else productName end as productName,
case when productLine is null then 'none' else productLine end as productLine,
case when productScale is null then '0' else productScale end as productScale,
case when productVendor is null then 'none' else productVendor end as productVendor,
case when quantityInStock is null then 0 else quantityInStock end as quantityInStock,
case when buyPrice is null then 0 else buyPrice end as buyPrice,
case when MSRP is null then 0 else MSRP end as MSRP

from `westeros-jdanilo.westeros_raw_data_layer.products`
)
;


create or replace table `westeros-jdanilo.westeros_qlty_data_layer.productlines_qty` (
productLine string,
textDescription string,
htmlDescription string,
image string,

)

;
insert `westeros-jdanilo.westeros_qlty_data_layer.productlines_qty`

select * from (
  select 
productLine,
textDescription,
htmlDescription,
image,

from `westeros-jdanilo.westeros_raw_data_layer.productlines`
)
;





