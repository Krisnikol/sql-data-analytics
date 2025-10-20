select category_id, category_name, category_tree
from categories
where category_tree ilike 'Toys & Games%';

select customer_id, first_name, last_name, email
from customers
where email ilike '%@gmail.com';

select product_id, name
from products
where name ilike '%Estrada%';

select product_id, name, base_price
from products
where base_price between 1500 and 2000;

SELECT employee_id, first_name, last_name, position, department
FROM employees
WHERE manager_id IS NULL;

SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    SUM(s.quantity * w.sales_price * (1 - COALESCE(s.discount, 0))) AS total_sales
FROM employees e
JOIN orders o   ON e.employee_id = o.employee_id
JOIN sales s    ON o.order_id = s.order_id
JOIN warehouse w ON s.wh_id = w.wh_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_sales DESC;

select customer_id, email
from customers
where email not like '%@%.%';

update customers
set email = null
where email not like '%@%.%';

select supplier_id, phone_number
from suppliers
where phone_number !~ '^[0-9+() -]+$'
   or phone_number is null;


update suppliers
set phone_number = regexp_replace(phone_number, '[^0-9+]+', '', 'g')
where phone_number is not null;






