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

-- NULL
WHERE COLUMN_NAME IS NOT NULL

-- LEFT JOIN vs INNER JOIN BETWEEN A AND B
Attach the image and rename this to a md file
