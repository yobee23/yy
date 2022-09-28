create database object;
use object;

create schema production;
go
create schema sales;
go
create table production.category(
category_id int identity(1,1) primary key,
category_name nvarchar(250) not null,
);

create table production.brand(
brand_id int identity(1,1) primary key,
brand_name varchar(250) not null,
);

create table production.products(
product_id int identity(1,1) primary key,
product_name nvarchar(250) not null,
brand_id int not null,
category_id int not null,
model_year smallint not null,
list_price decimal(10,2) not null,
foreign key (category_id) references production.category(category_id) on delete cascade on update cascade,
foreign key (brand_id) references production.brand(brand_id) on delete cascade on update cascade
);

create table sales.customers(
customer_id int identity (1,1) primary key,
frist_name varchar(255) not null,
last_name varchar (255) not null,
phone varchar(25),
email varchar(255) not null,
street varchar(255),
city varchar(50),
state varchar(25),
zip_code varchar(5)
);

select * from production.products;
select * from sales.customers;

create table sales.stores(
store_id int identity (1,1) primary key,
store_name varchar(255) not null,
phone varchar(25),
email varchar(255),
street varchar(255),
city varchar(50),
state varchar(10),
zip_code varchar(5)
);

create table sales.staffs(
staff_id int identity (1,1) primary key,
frist_name varchar(500) not null,
last_name varchar(50) not null,
email varchar(255) not null unique,
phone varchar(25),
active tinyint not null,
store_id int not null,
manager_id int,
foreign key (store_id) references sales.stores(store_id) on delete cascade on update cascade,
foreign key (manager_id) references sales.staffs(staff_id) on delete no action on update no action
);

create table sales.orders(
order_id int identity (1,1) primary key,
customer_id int,
order_data date not null,
required_data date not null,
shipped_date date,
store_id int not null,
staff_id int not null,
foreign key (customer_id) references sales.customers(customer_id) on delete cascade on update cascade,
foreign key (store_id) references sales.stores(store_id) on delete cascade on update cascade,
foreign key (staff_id) references sales.staffs(staff_id) on delete no action on update no action,
);

create table sales.order_items(
order_id int,
item_id int,
product_id int not null,
quantity int not null,
list_price decimal(10,2)not null,
discount decimal(4,2) not null default 0,
primary key (order_id, item_id),
foreign key (order_id) references sales.stores(store_id) on delete cascade on update cascade,
foreign key (product_id) references production.products(product_id) on delete cascade on update cascade,
);

create table production.stocks(
store_id int,
product_id int,
quantity int,
primary key (store_id, product_id),
foreign key (store_id) references sales.orders(order_id) on delete cascade on update cascade,
foreign key (product_id) references production.products(product_id) on delete cascade on update cascade,
);
