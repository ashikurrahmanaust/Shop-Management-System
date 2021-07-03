set serveroutput on

declare 
    c_id_ customer.c_id%TYPE;
    p_id_ product.p_id%TYPE;
    quan number;
    id shop.s_id%TYPE;
begin
    c_id_ := &customer_id;
    p_id_ := &product_id;
    quan := &quantity;
    id := insertoperations.getnexttransactionid;
    insertoperations.inserttransaction(id, c_id_, p_id_, quan);
end;
/
commit;