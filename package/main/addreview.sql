set serveroutput on

declare 
    c_id_ customer.c_id%TYPE := &customer_id;
    p_id_ product.p_id%TYPE := &product_id;
    rate review.rating%TYPE := &rating;
    id shop.s_id%TYPE;
begin
    id := insertoperations.getnextreviewid;
    insertoperations.insertreview(id, c_id_, p_id_, rate);
end;
/
commit;