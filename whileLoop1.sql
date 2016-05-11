CREATE FUNCTION "count_by_two" (integer) RETURNS integer AS '
  DECLARE
       userNum ALIAS FOR $1;
       i integer;
  BEGIN
       i := 1;
       WHILE userNum < 20 LOOP
             i = i+1;
             return userNum;
       END LOOP;
postgres'#
  END;
' LANGUAGE 'plpgsql';