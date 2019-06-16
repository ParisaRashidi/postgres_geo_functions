create or replace function grid_iran(lat1 double precision , lat2 double precision, long1 double precision, long2 double precision)  RETURNS void
  language plpgsql
as
$$
DECLARE
  current_long double precision;
  current_lat double precision;
BEGIN
  FOR x in 0..53 LOOP
      FOR y in 0..53 LOOP
          current_lat = lat1+((lat2-lat1)/54)*(y+1/2);
          current_long = long1+((long2-long1)/54)*(x+1/2);
           INSERT INTO tbl_lat_long_iran(lat,long)
           values (current_lat,current_long);


          END loop;
END LOOP ;
END;

$$;