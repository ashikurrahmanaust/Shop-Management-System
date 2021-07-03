create or replace package insertoperations as 

    procedure insertshop (s_id_ in shop.s_id%TYPE, name_ in shop.name%TYPE, division_ in 
        shop.division%TYPE, address_ in shop.address%TYPE, owner_name_ in shop.owner_name%TYPE);

    function getnextshopid return shop.s_id%TYPE;

    procedure insertcustomer (c_id_ in customer.c_id%TYPE, name_ in customer.name%TYPE, division_ in 
        customer.division%TYPE, address_ in customer.address%TYPE, phone_ in customer.phone%TYPE);

    function getnextcustomerid return customer.c_id%TYPE; 

    procedure insertproduct (p_id_ in product.p_id%TYPE, s_id_ in shop.s_id%TYPE, name_ in 
        product.name%TYPE, price_ in product.price%TYPE);

    function getnextproductid return product.p_id%TYPE;

    procedure inserttransaction (t_id_ in transaction.t_id%TYPE, c_id_ in customer.c_id%TYPE, p_id_ in 
        product.p_id%TYPE, quantity_ in transaction.quantity%TYPE);

    function getnexttransactionid return transaction.t_id%TYPE;

    procedure insertreview (r_id_ in review.r_id%TYPE, c_id_ in customer.c_id%TYPE, p_id_ in product.p_id%TYPE,
        rating_ number);

    function getnextreviewid return review.r_id%TYPE;

end insertoperations;
/
commit;