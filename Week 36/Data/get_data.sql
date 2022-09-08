SELECT COUNT(parts.part_num),
       COUNT(sets.set_num),
       sets.year
  FROM parts
 INNER JOIN part_categories
    ON parts.part_cat_id = part_categories.id
 INNER JOIN inventory_parts
    ON parts.part_num = inventory_parts.part_num
 INNER JOIN inventories
    ON inventory_parts.inventory_id = inventories.id
 INNER JOIN sets
    ON inventories.set_num = sets.set_num
 WHERE parts.name LIKE '%gun%'
    OR parts.name LIKE '%sword%'
    OR parts.name LIKE '%dagger%'
    OR parts.name LIKE '%axe%'
    OR parts.name LIKE '%weapon%'
    OR parts.name LIKE '%halberd%'
    OR parts.name LIKE '%lance%'
 GROUP BY sets.year;