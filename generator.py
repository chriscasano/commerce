#!/usr/local/bin/python
# Create Address
# Create Order
# Create Orderitems(1 - 10 per order)
# Create Suborders(10 % creation rate)

import random
import psycopg2
from datetime import date, timedelta

# Run execution
# Connection pool: https://pynative.com/psycopg2-python-postgresql-connection-pooling/

## Db Connections
host = "localhost"
port = "26257"
database = "commerce"
user = "root"

conn = psycopg2.connect(database=database, user=user, host=host, port=port)
conn.set_session(autocommit=True)
cur = conn.cursor()

i=0

while 1 <= 100:
  i+=1

  # Create Keys
  address_id = random.randint(1,999999999).__str__()
  member_id = random.randint(1,999999999).__str__()
  order_id = random.randint(1,999999999).__str__()
  addrbook_id = random.randint(1,999999999).__str__()
  storeent_id = random.randint(1,999999999).__str__()
  suborder_id = random.randint(1,999999999).__str__()


  # Insert Address
  cur.execute(""" 
    insert into address (address_id,member_id,addrbook_id,nickname)
    values ( """ + address_id + """,""" + member_id + """,""" + addrbook_id + """, 'test' );
    insert into orders ( orders_id, storeent_id, member_id )
    values ( """ + order_id + """,""" + storeent_id + """,""" + member_id + """ ); 
  """)

  # Insert Orderitems
  j=0
  num_items = address_id = random.randint(1,10)
  while j <= num_items:
    j+=1
    orderitems_id = random.randint(1, 999999999).__str__()
    rows = "(" + order_id + "," + orderitems_id + "," + storeent_id + "," + member_id + ",'N',1 )"
    if j == num_items:
      rows + ";"
    else:
      rows + ","

  cur.execute("""
    insert into orderitems (orders_id,orderitems_id,storeent_id,member_id,status,quantity) 
    values""" + rows
  )

  # Sub Orders (10% of the time)
  if ( i % 10 == 0 ):
    cur.execute("""
      insert into suborders(orders_id,suborder_id) 
      values ( """ + order_id + """,""" + suborder_id + """);"""
    )

else:
  print("done")

cur.close()
conn.close()


#  tradeid = i
#  description = ''.join(random.sample('ABCDEFGHIJKLM1234567890@#',15))
#  tradedate = date.today()
#  settlementdate = tradedate + timedelta(days=5)
#  traderid = random.randint(1,100)
#  brokerid = random.randint(1,20)
#  cusip = ''.join(random.sample('ABCDEFGHIJKLM1234567890@#',9))
#  settlementamount = random.randint(1,999999999)
#  count = random.randint(1,1000000)


