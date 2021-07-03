create or replace package updateoperations as 
    procedure removeproduct;

    procedure updateprice(s_id_ shop.s_id%TYPE, p_id_ product.p_id%TYPE, price_ product.price%TYPE);

end updateoperations;
/
commit;