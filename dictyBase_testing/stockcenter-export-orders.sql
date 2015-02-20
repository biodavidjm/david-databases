-- EXPORT-ORDERS

-- The export by default should contain the following fields ...

-- * email of ordering user.
-- * Date of order
-- * Strain/Plasmid/Bacterial Id of order. Do not exporting the primary key value of database table.
-- * And any other useful metadata that might be present.

--ALL TABLES

  SELECT 
  sorder.stock_order_id order_id,
  sorder.order_date,
  sc.id id,
  sc.systematic_name stock_name, 
  colleague.first_name,
  colleague.last_name,
  colleague.colleague_no,
  email.email 
  FROM cgm_ddb.stock_center sc
  JOIN cgm_ddb.stock_item_order sitem ON 
  ( 
      sc.id=sitem.item_id
      AND
      sc.strain_name = sitem.item
  ) 
  JOIN cgm_ddb.stock_order sorder ON sorder.stock_order_id=sitem.order_id
  JOIN cgm_ddb.colleague ON colleague.colleague_no = sorder.colleague_id
  JOIN cgm_ddb.coll_email colemail ON colemail.colleague_no=colleague.colleague_no
  JOIN cgm_ddb.email ON email.email_no=colemail.email_no
  UNION ALL
  SELECT 
  sorder.stock_order_id order_id, 
  sorder.order_date, 
  sc.id id, 
  sc.name stock_name, 
  colleague.first_name, 
  colleague.last_name, 
  colleague.colleague_no,
  email.email 
  FROM cgm_ddb.plasmid sc
  JOIN cgm_ddb.stock_item_order sitem ON 
  (
        sc.name=sitem.item
        AND
        sc.id = sitem.item_id
  )
  JOIN cgm_ddb.stock_order sorder ON sorder.stock_order_id=sitem.order_id
  JOIN cgm_ddb.colleague ON colleague.colleague_no = sorder.colleague_id
  JOIN cgm_ddb.coll_email colemail ON colemail.colleague_no=colleague.colleague_no
  JOIN cgm_ddb.email ON email.email_no=colemail.email_no

--




SELECT sorder.stock_order_id order_id, sc.id id, sc.systematic_name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
sorder.order_date FROM cgm_ddb.stock_center sc
JOIN cgm_ddb.stock_item_order sitem ON sc.id=sitem.item_id
JOIN cgm_ddb.stock_order sorder ON sorder.stock_order_id=sitem.order_id
JOIN cgm_ddb.colleague ON colleague.colleague_no = sorder.colleague_id
ORDER BY order_id

UNION ALL

SELECT sorder.stock_order_id order_id, sc.id id, sc.name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
sorder.order_date FROM plasmid sc
JOIN stock_item_order sitem ON sc.name=sitem.item
JOIN stock_order sorder ON sorder.stock_order_id=sitem.stock_item_order_id
JOIN colleague ON colleague.colleague_no = sorder.colleague_id

-- STOCK VIEW original

    select sorder.stock_order_id order_id,sc.id id, sc.systematic_name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
    sorder.order_date from stock_center sc
    join  stock_item_order sitem on 
     ( 
       sc.id=sitem.item_id
        AND
        sc.strain_name = sitem.item
     )   
    join stock_order sorder on sorder.stock_order_id=sitem.order_id
    join colleague on colleague.colleague_no = sorder.colleague_id
    UNION ALL
    select sorder.stock_order_id order_id,sc.id id, sc.name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
    sorder.order_date from plasmid sc
    join stock_item_order sitem on 
   (
          sc.name=sitem.item
          AND
          sc.id = sitem.item_id
    )
    join stock_order sorder on sorder.stock_order_id=sitem.stock_item_order_id
    join colleague on colleague.colleague_no = sorder.colleague_id
    where sitem.ITEM_ID='103'

-- Stock View corrected

(
    select sorder.stock_order_id order_id,sc.id id, sc.systematic_name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
    sorder.order_date from stock_center sc
    join  stock_item_order sitem on 
     ( 
       sc.id=sitem.item_id
        AND
        sc.strain_name = sitem.item
     )   
    join stock_order sorder on sorder.stock_order_id=sitem.order_id
    join colleague on colleague.colleague_no = sorder.colleague_id
    UNION ALL
    select sorder.stock_order_id order_id,sc.id id, sc.name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
    sorder.order_date from plasmid sc
    join stock_item_order sitem on 
   (
          sc.name=sitem.item
          AND
          sc.id = sitem.item_id
    )
    join stock_order sorder on sorder.stock_order_id=sitem.order_id
    join colleague on colleague.colleague_no = sorder.colleague_id
)

-- Stock view corrected + email address

select sorder.stock_order_id order_id, sc.id id, sc.systematic_name stock_name, 
colleague.first_name, colleague.last_name, colleague.colleague_no,
sorder.order_date, email.email from cgm_ddb.stock_center sc
join cgm_ddb.stock_item_order sitem on 
( 
    sc.id=sitem.item_id
    AND
    sc.strain_name = sitem.item
) 
join cgm_ddb.stock_order sorder on sorder.stock_order_id=sitem.order_id
join cgm_ddb.colleague on colleague.colleague_no = sorder.colleague_id
JOIN cgm_ddb.coll_email colemail ON colemail.colleague_no=colleague.colleague_no
JOIN cgm_ddb.email ON email.email_no=colemail.email_no
JOIN 
UNION ALL
select sorder.stock_order_id order_id,sc.id id, sc.name stock_name, 
colleague.first_name, colleague.last_name, colleague.colleague_no,
sorder.order_date, email.email from plasmid sc
join stock_item_order sitem on 
(
      sc.name=sitem.item
      AND
      sc.id = sitem.item_id
)
join stock_order sorder on sorder.stock_order_id=sitem.order_id
join colleague on colleague.colleague_no = sorder.colleague_id
JOIN cgm_ddb.coll_email colemail ON colemail.colleague_no=colleague.colleague_no
JOIN cgm_ddb.email ON email.email_no=colemail.email_no


-- TESTING NEW

SELECT so.stock_order_id, so.order_date, sio.item_id, sc.systematic_name item_name, 
dbxref.accession, colleague.first_name, colleague.last_name, email.email 
FROM cgm_ddb.stock_order so
JOIN cgm_ddb.stock_item_order sio ON so.stock_order_id=sio.order_id
JOIN cgm_ddb.stock_center sc ON sio.item_id=sc.id
JOIN cgm_chado.dbxref ON sc.dbxref_id=dbxref.dbxref_id
JOIN cgm_ddb.colleague ON so.colleague_id=colleague.colleague_no
JOIN cgm_ddb.coll_email colemail ON colleague.colleague_no=colemail.colleague_no
JOIN cgm_ddb.email ON colemail.email_no=email.email_no


-- Error?

SELECT sc.id, sc.systemic_name, sc.strain_name, sio.item_id,  sio.item
FROM stock_center sc 
JOIN stock_item_order sio  ON sc.id = sio.item_id 

SELECT sio.item_id, sio.order_id, sio.item item_name, pl.name plasmid_name, sc.strain_name, sc.systematic_name
FROM stock_item_order sio
JOIN stock_center sc ON sio.item_id=sc.id
JOIN plasmid pl ON sio.item_id=pl.id

SELECT sitem.item, sitem.item_id
FROM cgm_ddb.stock_center sc 
JOIN cgm_ddb.stock_item_order sitem ON sc.id = sitem.item_id 


-- LET'S COMBINE

SELECT so.stock_order_id, so.order_date, sio.item_id, sio.item item_name, 
colleague.first_name, colleague.last_name, email.email FROM cgm_ddb.stock_order so
JOIN cgm_ddb.stock_item_order sio ON so.stock_order_id=sio.order_id
JOIN cgm_ddb.colleague ON so.colleague_id=colleague.colleague_no
JOIN cgm_ddb.coll_email colemail ON colleague.colleague_no=colemail.colleague_no
JOIN cgm_ddb.email ON colemail.email_no=email.email_no


SELECT so.stock_order_id, so.order_date, sio.item_id, sio.item NAME FROM stock_order so
JOIN stock_item_order sio ON so.stock_order_id=sio.item_id
WHERE sio.item = 'pDM450'

-- LINKING PLASMID AND STOCK_ITEM_ORDER
SELECT sio.item_id, sio.item, plasmid.id, plasmid.name FROM stock_item_order sio
JOIN plasmid ON sio.item=plasmid.name
ORDER BY sio.item_id
WHERE sio.item = 'pDM450'

-- Is the plasmid.id and stock_item_order.id equal?
SELECT sio.item_id, plasmid.id FROM stock_item_order sio
JOIN plasmid ON sio.item=plasmid.name
ORDER BY sio.item_id

SELECT so.stock_order_id, sio.item_id, sio.item FROM stock_order so
JOIN STOCK_ITEM_ORDER sio ON so.stock_order_id=sio.item_id
ORDER BY sio.item_id

-- Studying relationship stock_center and plasmid

SELECT sc.id stock_center_id, pl.id plasmid_id, sc.strain_name, pl.name FROM stock_center sc
JOIN plasmid pl ON pl.id=sc.id

SELECT count(sc.id) stock_center_id FROM stock_center sc
JOIN plasmid pl ON pl.id=sc.id

SELECT sc.id stock_center_id, pl.id plasmid_id, sc.strain_name, pl.name FROM stock_center sc
JOIN plasmid pl ON pl.id=sc.id

SELECT sorder.stock_order_id order_id, sc.id id, sc.systematic_name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
sorder.order_date FROM cgm_ddb.stock_center sc
JOIN cgm_ddb.stock_item_order sitem ON sc.id=sitem.item_id
JOIN cgm_ddb.plasmid ON sitem.item_id
JOIN cgm_ddb.stock_order sorder ON sorder.stock_order_id=sitem.order_id
JOIN cgm_ddb.colleague ON colleague.colleague_no = sorder.colleague_id
ORDER BY order_id



-- ORDERS BY MONTH:
SELECT TO_CHAR(order_date, 'YYYY-MM'), COUNT(*)
FROM cgm_ddb.stock_order
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY 1

-- ORDERS BY YEAR:
SELECT TO_CHAR(order_date, 'YYYY'), COUNT(*)
FROM cgm_ddb.stock_order
GROUP BY TO_CHAR(order_date, 'YYYY')
ORDER BY 1

--ORDERS BY DAY:
SELECT TO_CHAR(order_date, 'YYYY-MM-DD'), COUNT(*)
FROM cgm_ddb.stock_order
GROUP BY TO_CHAR(order_date, 'YYYY-MM-DD')
ORDER BY 1
