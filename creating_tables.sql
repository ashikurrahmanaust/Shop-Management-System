clear screen;


drop table shop;
create table shop (
    s_id integer, name varchar2(20), division varchar2(15), 
    address varchar2(30), owner_name varchar2(20), 
    primary key(s_id)
);

drop table customer;
create table customer (
    c_id integer, name varchar2(20), division varchar2(15), 
    address varchar2(30), phone varchar2(20), 
    primary key(c_id)  
);

drop table product;
create table product (
    p_id integer, s_id integer, name varchar2(20),
    price number, 
    primary key(p_id)
);

drop table transaction;
create table transaction (
    t_id integer, c_id integer, p_id integer, quantity number, total number,
    primary key(t_id)
);

drop table review;
create table review (
    r_id integer, c_id integer, p_id integer, rating number,
    primary key(r_id)
);

commit;


