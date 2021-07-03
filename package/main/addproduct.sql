set serveroutput on

declare 
    s_id_ shop.s_id%TYPE := &shop_id;
    name_ product.name%TYPE := '&product_name';
    price_ product.price%TYPE := &price;
    id shop.s_id%TYPE;
begin
    id := insertoperations.getnextproductid;
    insertoperations.insertproduct(id, s_id_, name_, price_);
end;
/
commit;