create database orderdb;

use orderdb;

create table offices(
officeCode varchar(10) not null,
cityName varchar(50) not null,
phone varchar(10) not null,
address varchar(50) not null,
country varchar(50) not null,
postalCode varchar(10) not null, 
primary key(officeCode)
);

insert into offices values ('F101','pune','7418529635','Sainath Nagar, PCMC','IND','411044'),
('F102','kochi','8529529635','Nehru Nagar','IND','682001'),
('F103','Hyderabad','9582529635','Dilsukh Nagar','IND','500012');

create table employees(
            employeeNumaber varchar(10) not null,
            firstName varchar(50) not null,
            lastName varchar(50) not null,
            email varchar(100) not null,
            officeCode varchar(10) not null,
            reportsTO varchar(10) default null,
            jobTitle varchar(50) not null, 
            primary key(employeeNumaber),
            key(officeCode),
		    key(reportsTO),
		    foreign key(reportsTO) references employees(employeeNumaber),
            foreign key (officeCode) references offices(officeCode) 
 );
 
 insert into employees values('U2540','Ram','Kumar','ram@ust.com','F101',null,'Marketing Manager'),
                             ('U5402','Sam','Kumar','sam@ust.com','F102','U2540','Marketing Executive'),
							('U5403','Vinod','Kumar','vinod@ust.com','F103','U2540','Marketing Executive');


create table customers(
          customerNumaber varchar(10) not null,
          customerfirstName varchar(50) not null,
          customerlastName varchar(50) not null,
          cityName varchar(50) not null,
          phone varchar(10) not null,
          address varchar(50) not null,
          country varchar(50) not null,
          postalCode varchar(10) not null,
          salesRepEmployeeNumber varchar(10) default null,
          primary key(customerNumaber),
		  key(salesRepEmployeeNumber),
          foreign key(salesRepEmployeeNumber) references employees(employeeNumaber)
);
	
insert into customers values
('C0001','Raju','N','Bengaluru','9572852642','Navjivan, KPMP school','Ind','789456','U5402'),
('C0002','Mehrum','S','Kolkata','847772642','Building FSD','Ind','585282','U5402'),
('C0003','Nanda','Kumar','Chennai','9963575642','Avadi,CSI','Ind','666501','U5403');

create table payments(
			customerNumaber varchar(10) not null,
            checkNumaber varchar(50) not null,
            paymentDate date not null,
            amount decimal(8,2) not null,
            key(customerNumaber),
            foreign key(customerNumaber) references customers(customerNumaber) ,
            primary key(customerNumaber,checkNumaber)
            );

insert into payments values
('C0001','5240006952400','2021-07-24','15000'),
('C0002','7440006952405','2021-07-20','11000'),
('C0003','800075395958','2021-07-25','25000');

create table orders(
             orderNumber int(10) not null,
             orderedDate date not null,
             requiredDate date not null,
             shippedDate date default null,
             Orderstatus varchar(20) not null,
             customerNumaber varchar(10) not null,
             primary key(orderNumber),
             key(customerNumaber),
             foreign key(customerNumaber) references customers(customerNumaber) 
             );


insert into orders values
(1229,'2021-06-24','2021-07-01','2021-07-25','Shipped','C0001'),
(1130,'2021-06-20','2021-06-23','2021-07-22','Delivered','C0002'),
(1237,'2021-06-25','2021-06-29',null,'In Transit','C0003');


create table products(
             productCode varchar(15) not null,
             productName varchar(50)  not null,
             productLine varchar(50)  not null,
             productVendor varchar(50)  not null,
             productDescription text  not null,
             qutyInstock smallint(6)  not null,
             buyPrice decimal(8,2)  not null, 
             primary key (productCode),
             key (productLine),
             foreign key(productLine) references productLine(productLine)
             
             
);

insert into products values
('9795430563300','Redmi Note 10T','3','Redmi Pvt Ltd','The phone comes with a 6.67-inch touchscreen display with a resolution of 1080x2400 pixels and an aspect ratio of 20:9. Xiaomi Mi 10T 5G is powered by an octa-core Qualcomm Snapdragon 865 processor. It comes with 6GB of RAM. The Xiaomi Mi 10T 5G runs Android 10 and is powered by a 5000mAh non-removable battery.','400','15000'),
('9517531597548','Realme Narzo 30A','5','Realme Pvt Ltd','3 GB RAM | 32 GB ROM | Expandable Upto 256 GB 16.54 cm (6.51 inch) HD+ Display 13MP + 2MP | 8MP Front Camera 6000 mAh Battery MediaTek Helio G85 Processor.','1000','11000') ,
('74185496587458','OnePlus Nord CE 5G','2','OnePlus Pvt Ltd','64MP+8MP+2MP triple rear camera with 1080p video at 30/60 fps, 4k 30 fps | 16MP front camera with 1080p video at 30/60 fps. 6.43-inch, 90Hz fluid AMOLED display with 2400 x 1080 pixels resolution | Memory, Storage & SIM: 8GB RAM | 128GB internal memory on UFS 2.1 storage system..','800','25000');
 

create table orderDetails(
             orderNumber int(10) not null,
             productCode varchar(15) not null,
             quntityOrdered smallint(6) not null,
             priceOfEach decimal(7,2) not null,
             orderLineNumber tinyint(3) not null,
             
             key(productCode),
             foreign key(orderNumber) references orders(orderNumber) ,
             foreign key(productCode) references products(productCode)  ,
             primary key(orderNumber,productCode)
             );


insert into orderDetails values
(1229,'9795430563300','1','15000','3'),
(1130,'9517531597548','1','11000','5'),
(1237,'74185496587458','1','25000','2');

create table productLine(  
             productLine varchar(20) not null,
             textDescription varchar(1000) not null, 
             primary key (productLine)
             );
insert into productLine values 
('3','This is mobile phone manufacturing line 3'),
('5','This is mobile phone manufacturing line 5'),
('2','This is mobile phone manufacturing line 2');


show tables;

select * from customers;
select * from employees;
select * from offices;
select * from orders;
select * from productline;

select * from products;
select * from payments;
select * from orderdetails;

drop table customers;
drop table offices;
drop table employees;
drop table orders;
drop table productline;

drop table products;
drop table payments;
drop table orderdetails;