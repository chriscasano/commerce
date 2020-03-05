# Commerce
## A Simple Shopping Cart Workoad for CockroachDB

Roachprod is configured for Azure

schema.sql should be run first to init the database

generator.py is the workload (single threaded)

Prometheus can be used to collect metrics from CockroachDB

#### Tables

- ADDRESS - Customer addresses
- ORDER - The order header / summary
- SUBORDERS - Reseller item's the customer ordered
- ORDERITEMS - Item's the customer ordered

#### Keys

address_id, member_id, addrbook_id, storeent_id, suborder_id, orderitems_id

#### References

- address (1 <--> M) order
- address (1 <--> M) suborders
- address (1 <--> M) orderitems
- order (1 <-- M ) suborders
- order (1 <--> M ) orderitems

#### Data Gen Logic

- Create Address
- Create Order
- Create Orderitems (1 - 10 per order)
- Create Suborders (10% creation rate)
