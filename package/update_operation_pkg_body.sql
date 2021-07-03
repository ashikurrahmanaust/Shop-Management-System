set serveroutput on;
create or replace package body updateoperations as 
    procedure removeproduct is 
    id number;
    total number;
    cnt number;
    ans number;
    begin
        for pro in (select * from product) loop
            total := 0;
            cnt := 0;
            for rev in (select * from review) loop
                if (pro.p_id = rev.p_id) then
                    cnt := cnt + 1;
                    total := total + rev.rating;
                end if;   
            end loop;
            if (cnt = 0) then
                cnt := 1;
            end if;
            ans := total / cnt;
            if (ans < 2.5 and cnt > 0) then
                dbms_output.put_line(pro.name || ' has been removed for bad review!');
                delete from product where p_id = pro.p_id;
            end if;
        end loop;
    exception 
        when zero_divide then       
            dbms_output.put_line('Product not Exist!');
    end removeproduct;

    procedure updateprice(s_id_ shop.s_id%TYPE, p_id_ product.p_id%TYPE, price_ product.price%TYPE) is
    begin
        update product set price = price_ where s_id = s_id_ and p_id = p_id_;
    end updateprice;



end updateoperations;
/


commit;