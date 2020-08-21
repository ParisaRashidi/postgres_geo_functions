--step1: create a table to store latitude and longitude
create table tbl_grid  (
   lat double precision,
   long double precision
);


--create function in postgres
create or replace function point_distributor(latitudePoint1  double precision ,
                                             latitudePoint2 double precision,
                                             longitudePoint1 double precision,
                                             longitudePoint2 double precision,
                                             x integer,--the length
                                             y integer -- the width
                                             )  RETURNS void
  language plpgsql
as
$$
DECLARE
  grid_view_longitude double precision;
  grid_view_latitude double precision;
BEGIN
  FOR i in 0..x LOOP
      FOR j in 0..y LOOP
          grid_view_latitude = latitudePoint1+((latitudePoint2-latitudePoint1)/x)*(i+1/2);
          grid_view_longitude = longitudePoint1 +((longitudePoint2-longitudePoint1)/y)*(j+1/2);
           INSERT INTO tbl_grid(lat,long)
           values (grid_view_latitude,grid_view_longitude);
          END loop;
END LOOP ;
END;

$$;


--how to use this function
select point_distributor(POINT1_LATTITUDE,
                         POINT2_LATTITUDE,
						 POINT1_LONGTITUDE,
						 POINT2_LONGTITUDE,
						 X,
						 Y);

--now select the created table and see the points , my srid is = 4326
select st_setsrid(st_makepoint(long,lat), integer SRID) from tbl_grid;

