--CREATE TABLE
    --addresses (
        --address_id SERIAL PRIMARY KEY,
        --country VARCHAR(150),
        --region VARCHAR(150),
        --city VARCHAR(150),
        --street VARCHAR(150),
        --building_number INT,
        --zip VARCHAR(150),
        --parent_id INT);            

--CREATE TABLE
    --customers (
        --customer_id SERIAL PRIMARY KEY,
        --first_name VARCHAR(150),
        --last_name VARCHAR(150),
        --gender VARCHAR(150),
        --birth_date TIMESTAMPTZ,
        --age INT,
        --age_group VARCHAR(150),
        --email VARCHAR(150),
        --phone VARCHAR(150),
        --address_id INT,
        --preferences JSONB);            

--CREATE TABLE
    --categories (
        --category_id SERIAL PRIMARY KEY,
        --category_name VARCHAR(150),
        --category_tree VARCHAR(150),
        --parent_category_id INT);            

--CREATE TABLE
    --products (
        --product_id SERIAL PRIMARY KEY,
        --name VARCHAR(150),
        --category_id INT,
        --base_price NUMERIC(10,2),
        --date_added TIMESTAMPTZ,
        --date_updated TIMESTAMPTZ);            

--CREATE TABLE
    --suppliers (
        --supplier_id SERIAL PRIMARY KEY,
        --name VARCHAR(150),
        --email VARCHAR(150),
        --phone_number VARCHAR(150),
        --agent VARCHAR(150),
        --type INT);            

--CREATE TABLE
    --warehouse (
        --wh_id SERIAL PRIMARY KEY,
        --product_id INT,
        --supplier_id INT,
        --price NUMERIC(10,2),
        --procurement NUMERIC(10,2),
        --markup NUMERIC(10,2),
        --sales_price NUMERIC(10,2),
        --stock_quantity INT);            

--CREATE TABLE
    --stores (
        --store_id SERIAL PRIMARY KEY,
        --store_type VARCHAR(150),
        --store_name VARCHAR(150),
        --address_id INT,
        --url VARCHAR(150));            

--CREATE TABLE
    --employees (
        --employee_id SERIAL PRIMARY KEY,
        --first_name VARCHAR(150),
        --last_name VARCHAR(150),
        --department VARCHAR(150),
        --position VARCHAR(150),
        --manager_id INT,
        --store_id INT,
        --salary INT,
        --commission NUMERIC(10,2),
        --hire_date TIMESTAMPTZ);            

--CREATE TABLE
    --orders (
        --order_id SERIAL PRIMARY KEY,
        --customer_id INT,
        --employee_id INT,
        --date TIMESTAMPTZ,
        --order_value NUMERIC(10,2),
        --status VARCHAR(150),
        --delivery_date TIMESTAMPTZ,
        --payment_method VARCHAR(150),
        --payment_status VARCHAR(150));            

--CREATE TABLE
    --sales (
        --sale_id SERIAL PRIMARY KEY,
        --order_id INT,
        --wh_id INT,
        --quantity INT,
        --discount NUMERIC(10,2));  

--alter table addresses
--add constraint fk_addresses_parent
--foreign key(parent_id) references addresses (address_id);

--select * from addresses
--where parent_id = 0 and region is null;

--update addresses 
--set parent_id = null 
--where parent_id = 0 and region is null;

--select * from addresses
--order by address_id;

--select * from addresses 
--where building_number = 0;

--update addresses
--set building_number = null 
--where building_number = 0;

--select parent_id
--from addresses
--where parent_id is not null
  --and parent_id not in (select address_id from addresses);

--update addresses
--set parent_id = null
--where parent_id = 0 or parent_id not in (select address_id from addresses);

--alter table addresses
--add constraint fk_addresses_parent
--foreign key (parent_id) references addresses(address_id)
--on delete set null;

select * from customers;

alter table customers
add constraint fk_customers_address
foreign key (address_id)
references addresses(address_id)
on delete set null;

select * from categories;

update categories
set parent_category_id = null
where parent_category_id = 0;

select parent_category_id
from categories
where parent_category_id is not null
  and parent_category_id not in (select category_id from categories);

  alter table categories
add constraint fk_categories_parent
foreign key (parent_category_id)
references categories(category_id)
on delete set null;

update products 
set category_id = null  
where category_id = 0;

select * from products;

alter table products
  add constraint fk_products_category
  foreign key (category_id)
  references categories(category_id)
  on delete set null;
 
 select * from employees;

update employees
set department = null
where department = '???';

update employees e
set manager_id = null
where manager_id = 0;


alter table employees
add constraint fk_employees_manager
foreign key (manager_id) references employees(employee_id)
on delete set null;

select * from orders;

update orders set customer_id = null  
where customer_id = 0;

update orders set employee_id = null  
where employee_id = 0;

alter table orders
  add constraint fk_orders_customer
  foreign key (customer_id) 
  references customers(customer_id)
  on delete restrict;

alter table orders
  add constraint fk_orders_employee
  foreign key (employee_id) 
  references employees(employee_id)
  on delete set null;

select * from sales;

update sales 
set order_id = null  
where order_id = 0;

update sales 
set wh_id = null  
where wh_id = 0;

alter table sales
  add constraint fk_sales_orders
  foreign key (order_id) 
  references orders(order_id)
  on delete set null;

alter table sales
  add constraint fk_sales_wh
  foreign key (wh_id) 
  references warehouse(wh_id)
  on delete set null;

  select * from stores

update stores
set address_id = null
where address_id = 0;

alter table stores
add constraint fk_stores_address
foreign key (address_id)
references addresses(address_id)
on delete set null;

select * from warehouse;

update warehouse w
set product_id = null
where w.product_id not in (select product_id from products);

update warehouse w
set supplier_id = null
where w.supplier_id not in (select supplier_id from suppliers);

alter table warehouse
add constraint fk_warehouse_product
foreign key (product_id) references products(product_id)
on delete set null;

alter table warehouse
add constraint fk_warehouse_supplier
foreign key (supplier_id) references suppliers(supplier_id)
on delete set null;


 


