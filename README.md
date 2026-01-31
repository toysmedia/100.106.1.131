# Foreign Key Constraint Fix

## Problem
The Laravel migration `2026_01_12_040006_create_inventory_item_lots_table` was failing with:

```
SQLSTATE[HY000]: General error: 1005 Can't create table `ems_oxnet`.`inventory_item_lots` 
(errno: 150 "Foreign key constraint is incorrectly formed")
```

The specific constraint failing was:
```sql
ALTER TABLE `inventory_item_lots` 
ADD CONSTRAINT `inventory_item_lots_receipt_id_foreign` 
FOREIGN KEY (`receipt_id`) REFERENCES `inventory_receipts` (`id`) 
ON DELETE SET NULL
```

## Root Cause
MySQL foreign key constraint error (errno: 150) occurs when using `ON DELETE SET NULL` with a **NOT NULL** column. The column being constrained must be nullable to allow the database to set it to NULL when the referenced row is deleted.

## Solution
Changed the `receipt_id` column definition in the `inventory_item_lots` table from:
```php
$table->unsignedBigInteger('receipt_id');  // NOT NULL - causes error
```

To:
```php
$table->unsignedBigInteger('receipt_id')->nullable();  // Nullable - allows ON DELETE SET NULL
```

## Migration Files

### 1. `2026_01_12_040005_create_inventory_receipts_table.php`
Creates the `inventory_receipts` table that is referenced by the foreign key.

### 2. `2026_01_12_040006_create_inventory_item_lots_table.php`
Creates the `inventory_item_lots` table with the corrected foreign key constraint:
- `receipt_id` is **nullable**
- Foreign key uses `onDelete('set null')`

## How to Use
To apply these migrations in your Laravel application:

```bash
php artisan migrate
```

The migrations will run in order (by timestamp) and the foreign key constraint will be created successfully.

## Key Takeaway
When using `ON DELETE SET NULL` (or `onDelete('set null')` in Laravel), the foreign key column **must be nullable**.
