SELECT * FROM customer;
SELECT * FROM interactions;

---1--- Customers with a high average interaction score:
SELECT 
c.customer_id,
c.first_name,
c.last_name,
AVG(i.interaction_score) AS avg_interaction_score
FROM 
customer c
JOIN 
interactions i ON c.customer_id = i.customer_id
GROUP BY 
c.customer_id, c.first_name, c.last_name
HAVING AVG(i.interaction_score) > 8;

---2--- Male customers with interaction data:
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    i.interaction_type,
    i.interaction_score
FROM 
    customer c
JOIN 
    interactions i ON c.customer_id = i.customer_id
WHERE 
    c.gender = 'Male';

---3--- Find customers with no interactions

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM 
    customer c
LEFT JOIN 
    interactions i ON c.customer_id = i.customer_id
WHERE 
    i.interaction_id IS NULL;

---4--- Count interactions per customer
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    i.interaction_type,
    COUNT(i.interaction_id) AS total_interactions
FROM 
    customer c
JOIN 
    interactions i ON c.customer_id = i.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, i.interaction_type;

---5--- Find customers with a specific interaction type(phone)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    i.interaction_type,
    i.interaction_score
FROM 
    customer c
JOIN 
    interactions i ON c.customer_id = i.customer_id
WHERE 
    i.interaction_type = 'Phone';
