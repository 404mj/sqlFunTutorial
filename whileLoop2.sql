CREATE FUNCTION add_two_loop (integer, integer) RETURNS integer AS '
  DECLARE
     -- Declare aliases for function arguments.
    low_number ALIAS FOR $1;
    high_number ALIAS FOR $2;
     -- Declare a variable to hold the result.
    result INTEGER = 0;
  BEGIN
     -- Add one to the variable result until the value of result is
     -- equal to high_number.
    WHILE result != high_number LOOP
      result := result + 1;
    END LOOP;
    RETURN result;
  END;
' LANGUAGE 'plpgsql';