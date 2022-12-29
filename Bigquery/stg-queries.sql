create or replace table `westeros-jdanilo.westeros_stg_data_layer.westeros_tablon_stg` 
(
orderNumber int64,
productCode string,
quantityOrdered int64,
priceEach float64,
totalSale float64,
orderDate date,
status string,
customerNumber int64,
productName string,
productLine string,
quantityInStock int64,
buyPrice float64,
MSRP float64,
city string,
country string,
creditLimit float64,
employeeNumber int64,
officeCode string,
paymentDate date,
amount float64)
;
insert `westeros-jdanilo.westeros_stg_data_layer.westeros_tablon_stg` 

select * from (
  select orderNumber,
productCode ,
quantityOrdered,
priceEach,
totalSale,
orderDate,
status,
ordetails_produ.customerNumber,
productName,
productLine,
quantityInStock,
buyPrice,
MSRP,
city,
country,
creditLimit,
employeeNumber,
officeCode,
paymentDate,
amount

from (SELECT ordetails.orderNumber,ordetails.productCode,quantityOrdered,priceEach,totalSale,orderDate,status,customerNumber,productName,productLine,quantityInStock,buyPrice,MSRP FROM `westeros-jdanilo.westeros_acc_data_layer.orderdetails_acc` ordetails 
Inner JOIN `westeros-jdanilo.westeros_acc_data_layer.orders_acc` orde
ON ordetails.orderNumber = orde.orderNumber 
Inner JOIN `westeros-jdanilo.westeros_acc_data_layer.products_acc` produ  
ON ordetails.productCode = produ.productCode) ordetails_produ
inner JOIN
(SELECT cust.customerNumber,city,country,creditLimit,employeeNumber,officeCode,paymentDate,amount FROM `westeros-jdanilo.westeros_acc_data_layer.customers_acc` cust
inner JOIN `westeros-jdanilo.westeros_acc_data_layer.employees_acc` empl 
ON empl.employeeNumber = cust.salesRepEmployeeNumber
inner JOIN `westeros-jdanilo.westeros_acc_data_layer.payments_acc` paym 
ON cust.customerNumber = paym.customerNumber) cust_empl_paym
ON ordetails_produ.customerNumber = cust_empl_paym.customerNumber
);
