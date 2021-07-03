set serveroutput on

declare 
    name_ shop.name%TYPE;
    division_ shop.division%TYPE;
    address_ shop.address%TYPE;
    phone_ shop.owner_name%TYPE;
    id shop.s_id%TYPE;
begin
    name_ := '&user_name';
    division_ := '&city';
    address_ := '&address';
    phone_ := '&phone_number';
    id := insertoperations.getnextcustomerid;
    insertoperations.insertcustomer(id, name_, division_, address_, phone_);
end;
/
commit;