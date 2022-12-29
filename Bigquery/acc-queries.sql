create or replace table `westeros-jdanilo.westeros_acc_data_layer.customers_acc` (
customerNumber int64,
city string,
country string,
salesRepEmployeeNumber int64,
creditLimit float64
)

;
insert `westeros-jdanilo.westeros_acc_data_layer.customers_acc`

select * from (
  select customerNumber,
city,
country,
salesRepEmployeeNumber,
creditLimit
from `westeros-jdanilo.westeros_qlty_data_layer.customers_qty`
)
;



create or replace table `westeros-jdanilo.westeros_acc_data_layer.employees_acc` (employeeNumber int64,officeCode string)

;
insert `westeros-jdanilo.westeros_acc_data_layer.employees_acc`

select * from (
  select employeeNumber,officeCode from `westeros-jdanilo.westeros_qlty_data_layer.employees_qty`
)
;



create or replace table `westeros-jdanilo.westeros_acc_data_layer.offices_acc` (officeCode string, city string, country string)

;
insert `westeros-jdanilo.westeros_acc_data_layer.offices_acc`

select * from (
  select officeCode, city, country from `westeros-jdanilo.westeros_qlty_data_layer.offices_qty`
)
;




create or replace table `westeros-jdanilo.westeros_acc_data_layer.orders_acc` (orderNumber int64,orderDate date,status string,customerNumber int64)

;
insert `westeros-jdanilo.westeros_acc_data_layer.orders_acc`

select * from (
  select orderNumber,orderDate,status,customerNumber from `westeros-jdanilo.westeros_qlty_data_layer.orders_qty`
)
;



create or replace table `westeros-jdanilo.westeros_acc_data_layer.orderdetails_acc` (orderNumber int64,
productCode string,
quantityOrdered int64,
priceEach float64,
totalSale float64)
;
insert `westeros-jdanilo.westeros_acc_data_layer.orderdetails_acc`

select * from (
  select orderNumber,productCode,quantityOrdered,priceEach,ROUND(quantityOrdered*priceEach,2) as totalSale from `westeros-jdanilo.westeros_qlty_data_layer.orderdetails_qty`
)
;



create or replace table `westeros-jdanilo.westeros_acc_data_layer.payments_acc` (customerNumber int64,paymentDate date,amount float64)

;
insert `westeros-jdanilo.westeros_acc_data_layer.payments_acc`

select * from (
  select customerNumber,paymentDate,amount from `westeros-jdanilo.westeros_qlty_data_layer.payments_qty`
)
;



create or replace table `westeros-jdanilo.westeros_acc_data_layer.products_acc` (
productCode string,
productName string,
productLine string,
quantityInStock int64,
buyPrice float64,
MSRP float64)

;
insert `westeros-jdanilo.westeros_acc_data_layer.products_acc`

select * from (
  select productCode,productName,productLine,quantityInStock,buyPrice,MSRP
from `westeros-jdanilo.westeros_qlty_data_layer.products_qty`
)
;


