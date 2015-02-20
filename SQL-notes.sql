-- SQL statements


-- GENERAL

-- INFO FROM ORACLE:
-- Oracle version:
SELECT * FROM PRODUCT_COMPONENT_VERSION;

-- SID: 
select value from v$parameter where name='service_names'


-- COUNT THE OUTPUT OF A STATEMENT:
SELECT count(*) FROM
(
    SELECT whatever...
)


