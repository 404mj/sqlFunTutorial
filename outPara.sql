create function saleTax(IN subtotal real,OUT tax real) as $$
    --IN is optional ,and in this way the 'returns integer' is not needed.
    --OUT parameter sometimes is very useful!
    begin 
        tax := subtotal * 0.06;
    end;
$$ language plpgsql;


--real number format
-- select saleTax(100);