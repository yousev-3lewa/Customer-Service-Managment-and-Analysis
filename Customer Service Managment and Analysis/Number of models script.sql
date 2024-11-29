
CREATE FUNCTION numberOfPhone(@man VARCHAR(50))
RETURNS TABLE
AS
RETURN (
  SELECT COUNT(product_id) AS [count]
  FROM products
  WHERE manufacturer = @man
);

select * from numberOfPhone('Apple')

CREATE FUNCTION biggerThan(@x int)
returns table
as
return(
select count(product_id) as [count] from products where price > @x
);

select * from biggerThan(10000)

CREATE FUNCTION smallerThan(@x int)
returns table
as
return(
select count(product_id) as [count] from products where price < @x
);

select * from smallerThan(10000)

