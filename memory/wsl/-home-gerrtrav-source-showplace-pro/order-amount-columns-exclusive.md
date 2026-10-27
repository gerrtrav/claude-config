---
name: order-amount-columns-exclusive
description: "On the orders table only one of quote_amount / order_amount is filled per row, so Order::totalAmount() (their sum) is correct as-is"
metadata:
  node_type: memory
  type: project
  originSessionId: 182d0fdb-a2f9-45f3-8027-d4445ab13efb
  modified: 2026-10-06T15:44:50.885Z
---

In the `orders` table, each row has only `quote_amount` or `order_amount` filled out, never both. So `Order::totalAmount()`, which returns `quote_amount + order_amount`, always gives the right amount and does not need an `order_status == 'QT'` check.

**Why:** the user said so on 2026-10-06 (SPPRO-4799), when asked whether `totalAmount()` should follow the same QT rule as the report rows and exports.

**How to apply:** don't flag `totalAmount()` or its uses (report row detail, order details popover) as inconsistent with the `order_status == 'QT' ? quote_amount : order_amount` pattern.
