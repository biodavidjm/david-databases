EXPORT-ORDERS

The export by default should contain the following fields ...

* email of ordering user.
* Date of order
* Strain/Plasmid/Bacterial Id of order. Do not exporting the primary key value of database table.
* And any other useful metadata that might be present.

### The SQL:

```
SELECT sorder.stock_order_id order_id, sc.id id, sc.systematic_name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
sorder.order_date FROM stock_center sc
join stock_item_order sitem on sc.id=sitem.item_id
join stock_order sorder on sorder.stock_order_id=sitem.order_id
join colleague on colleague.colleague_no = sorder.colleague_id

UNION ALL

select sorder.stock_order_id order_id, sc.id id, sc.name stock_name, colleague.first_name, colleague.last_name, colleague.colleague_no,
sorder.order_date from plasmid sc
join stock_item_order sitem on sc.name=sitem.item
join stock_order sorder on sorder.stock_order_id=sitem.stock_item_order_id
join colleague on colleague.colleague_no = sorder.colleague_id
```

### Example:

* Export a csv format of dictybase colleagues and their associated genes

```
SELECT email.email, feature.uniquename FROM cgm_ddb.email 
JOIN cgm_ddb.coll_email ON 
  email.email_no = coll_email.email_no
  JOIN cgm_ddb.coll_locus ON 
    coll_email.colleague_no = coll_locus.colleague_no
    JOIN feature ON
      coll_locus.locus_no = feature.feature_id
      ORDER BY email.email
```

