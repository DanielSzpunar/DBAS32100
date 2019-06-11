CREATE TABLE copy_options AS SELECT * FROM si.options;
--DROP TABLE copy_options;
select * from copy_options;
SELECT * FROM copy_options WHERE optiondesc LIKE '%ROOF%';
--EXPLAIN PLAN FOR SELECT * FROM copy_options WHERE optiondesc LIKE '%ROOF%';
--CREATE INDEX IXcopy_options_optiondesc ON copy_options (optiondesc asc);
CREATE INDEX IX_copy_options_optiondesc ON copy_options(optiondesc);
--DROP INDEX IXcopy_options_optiondesc;
SELECT * FROM table(dbms_xplan.display());
--CREATE BITMAP INDEX IX_test ON copy_options(copy_options.optiondesc)
--FROM copy_options WHERE copy_options.optiondesc LIKE '%ROOF%';

