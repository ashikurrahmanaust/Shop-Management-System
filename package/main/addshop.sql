set serveroutput on

declare 
    name_ shop.name%TYPE;
    division_ shop.division%TYPE;
    address_ shop.address%TYPE;
    owner_name_ shop.owner_name%TYPE;
    id shop.s_id%TYPE;
begin
    name_ := '&shop_name';
    division_ := '&city';
    address_ := '&address';
    owner_name_ := '&owner_name';
    id := insertoperations.getnextshopid;
    insertoperations.insertshop(id, name_, division_, address_, owner_name_);
end;
/
commit;