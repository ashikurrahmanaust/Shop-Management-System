set serveroutput on;
create or replace package body insertoperations as 
    
    procedure insertshop (s_id_ in shop.s_id%TYPE, name_ in shop.name%TYPE, division_ in 
        shop.division%TYPE, address_ in shop.address%TYPE, owner_name_ in shop.owner_name%TYPE) is 
        
    begin
        if (division_ = 'rajshahi' or division_ = 'rangpur') then
            insert into shop values(s_id_, name_, division_, address_, owner_name_);
        else 
            insert into shop@site_link values(s_id_, name_, division_, address_, owner_name_);
        end if;
    end insertshop;

    procedure insertcustomer (c_id_ in customer.c_id%TYPE, name_ in customer.name%TYPE, division_ in 
        customer.division%TYPE, address_ in customer.address%TYPE, phone_ in customer.phone%TYPE) is 
    begin
        insert into customer values(c_id_, name_, division_, address_, phone_);
    end insertcustomer;

    procedure insertproduct (p_id_ in product.p_id%TYPE, s_id_ in shop.s_id%TYPE, name_ in 
        product.name%TYPE, price_ in product.price%TYPE) is 
    shop_not_found exception;
    flag number;
    f number;
    begin 
        flag := 0;
        for itr in (select s_id from shop) loop 
            if (itr.s_id = s_id_) then
                flag := 1;
                exit;
            end if;       
        end loop;
        f := 0;
        for itr in (select s_id from shop@site_link) loop 
            if (itr.s_id = s_id_) then
                f := 1;
                exit;
            end if;       
        end loop;
        
        if (flag = 0 and f = 0) then raise shop_not_found;
        end if;
        insert into product values(p_id_, s_id_, name_, price_);
        exception 
            when shop_not_found then
                dbms_output.put_line('This shop does not exist');
    end insertproduct;  

    procedure inserttransaction (t_id_ in transaction.t_id%TYPE, c_id_ in customer.c_id%TYPE, p_id_ in 
        product.p_id%TYPE, quantity_ in transaction.quantity%TYPE) is 
    invalid_customer exception;
    invalid_product exception;
    total_ transaction.total%TYPE;
    price_ product.price%TYPE := 0;
    flag number;
    begin
        flag := 0;
        for itr in (select c_id from customer) loop
            if (itr.c_id = c_id_) then
                flag := 1;
            end if;
        end loop;
        if (flag = 0) then
            raise invalid_customer;
        end if;
        flag := 0;
        for itr in (select p_id from product) loop
            if (itr.p_id = p_id_) then
                flag := 1;
            end if;
        end loop;
        if (flag = 0) then
            raise invalid_product;
        end if;
        for itr in (select p_id, price from product) loop
            if (itr.p_id = p_id_) then
                price_ := itr.price;
                exit;
            end if;
        end loop;
        total_ := price_ * quantity_;
        insert into transaction values(t_id_, c_id_, p_id_, quantity_, total_);
        exception 
            when invalid_customer then
                dbms_output.put_line('Customer did not found!');
            when invalid_product then
                dbms_output.put_line('Product did not found!');
    end inserttransaction;

    procedure insertreview (r_id_ in review.r_id%TYPE, c_id_ in customer.c_id%TYPE, p_id_ in product.p_id%TYPE,
        rating_ number) is
    flag number; 
    did_not_buy exception;
    begin 
        flag := 0;
        for itr in (select * from transaction) loop
            if (itr.c_id = c_id_ and itr.p_id = p_id_) then
                flag := 1;
                exit;
            end if;
        end loop;
        if (flag = 0) then
            raise did_not_buy;
        end if;
        insert into review values(r_id_, c_id_, p_id_, rating_);

    exception
        when did_not_buy then
            dbms_output.put_line('Buyer and product did not match');

    end insertreview;

    function getnextshopid return shop.s_id%TYPE is
    flag number;
    x number := 0;
    y number := 0;
    mx number := 0;
    begin
        for i in 1..1000 loop
            flag := 0;
            for itr in (select s_id from shop) loop
                if (i = itr.s_id) then
                    flag := 1;
                    exit;
                end if;
            end loop;
            if (flag = 1) then
                x := i;
            end if;
        end loop;
        mx := x;
        for i in 1..1000 loop
            flag := 0;
            for itr in (select s_id from shop@site_link) loop
                if (i = itr.s_id) then
                    flag := 1;
                    exit;
                end if;
            end loop;
            if (flag = 1) then
                y := i;
            end if;
        end loop;
        if (y > mx) then
            mx := y;
        end if;
        return (mx + 1);
    end getnextshopid;

    function getnextcustomerid return customer.c_id%TYPE is
    flag number;
    begin
        for i in 1..1000 loop
            flag := 0;
            for itr in (select c_id from customer) loop
                if (i = itr.c_id) then
                    flag := 1;
                    exit;
                end if;
            end loop;
            if (flag = 0) then
                return i;
                exit;
            end if;
        end loop;
        return -1;
    end getnextcustomerid;

    function getnextproductid return product.p_id%TYPE is
    flag number;
    begin
        for i in 1..1000 loop
            flag := 0;
            for itr in (select p_id from product) loop
                if (i = itr.p_id) then
                    flag := 1;
                    exit;
                end if;
            end loop;
            if (flag = 0) then
                return i;
                exit;
            end if;
        end loop;
        return -1;
    end getnextproductid;

    function getnexttransactionid return transaction.t_id%TYPE is
    flag number;
    begin
        for i in 1..1000 loop
            flag := 0;
            for itr in (select t_id from transaction) loop
                if (i = itr.t_id) then
                    flag := 1;
                    exit;
                end if;
            end loop;
            if (flag = 0) then
                return i;
                exit;
            end if;
        end loop;
        return -1;
    end getnexttransactionid;

    function getnextreviewid return review.r_id%TYPE is
    flag number;
    begin
        for i in 1..1000 loop
            flag := 0;
            for itr in (select r_id from review) loop
                if (i = itr.r_id) then
                    flag := 1;
                    exit;
                end if;
            end loop;
            if (flag = 0) then
                return i;
                exit;
            end if;
        end loop;
        return -1;
    end getnextreviewid;

end insertoperations;
/

commit;