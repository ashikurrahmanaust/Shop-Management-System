create or replace view myshop (shop_name, city, owner) as
select name, division, owner_name from shop;

select * from myshop;