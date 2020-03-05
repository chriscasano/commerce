CREATE DATABASE IF NOT EXISTS COMMERCE;

USE COMMERCE;

CREATE TABLE IF NOT EXISTS orders (
	orders_id INT8 NOT NULL,
	ormorder CHAR(30) NULL,
	orgentity_id INT8 NULL,
	totalproduct DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	totaltax DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	totalshipping DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	totaltaxshipping DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	description VARCHAR(254) NULL,
	storeent_id INT8 NOT NULL,
	currency CHAR(10) NULL,
	locked CHAR NULL,
	timeplaced TIMESTAMP NULL,
	lastupdate TIMESTAMP NULL,
	sequence DECIMAL NOT NULL DEFAULT 0:::DECIMAL,
	status VARCHAR(3) NULL,
	member_id INT8 NOT NULL,
	field1 INT8 NULL,
	address_id INT8 NULL,
	field2 DECIMAL(20,5) NULL,
	providerordernum INT8 NULL,
	shipascomplete CHAR NOT NULL DEFAULT 'Y':::STRING,
	field3 VARCHAR(254) NULL,
	totaladjustment DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	ordchnltyp_id INT8 NULL,
	comments VARCHAR(254) NULL,
	notificationid INT8 NULL,
	type CHAR(3) NULL,
	optcounter INT2 NULL,
	editor_id INT8 NULL,
	buschn_id INT8 NULL,
	sourceid INT8 NULL,
	expiredate TIMESTAMP NULL,
	blocked INT2 NULL DEFAULT 0:::INT8,
	opsystem_id INT8 NULL,
	transferstatus INT2 NULL,
	buyerpo_id INT8 NULL,
	CONSTRAINT "primary" PRIMARY KEY (orders_id ASC),
	FAMILY "primary" (orders_id, ormorder, orgentity_id, totalproduct, totaltax, totalshipping, totaltaxshipping, description, storeent_id, currency, locked, timeplaced, lastupdate, sequence, status, member_id, field1, address_id, field2, providerordernum, shipascomplete, field3, totaladjustment, ordchnltyp_id, comments, notificationid, type, optcounter, editor_id, buschn_id, sourceid, expiredate, blocked, opsystem_id, transferstatus, buyerpo_id)
);

CREATE TABLE IF NOT EXISTS suborders (
	orders_id INT8 NOT NULL,
	suborder_id INT8 NOT NULL,
	address_id INT8 NULL,
	country CHAR(30) NULL,
	totalproduct DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	totaltax DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	totalshipping DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	totaltaxshipping DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	currency CHAR(10) NULL,
	field1 INT8 NULL,
	field2 DECIMAL(20,5) NULL,
	field3 VARCHAR(254) NULL,
	totaladjustment DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	optcounter INT2 NULL,
	CONSTRAINT "primary" PRIMARY KEY (suborder_id ASC),
	FAMILY "primary" (orders_id, suborder_id, address_id, country, totalproduct, totaltax, totalshipping, totaltaxshipping, currency, field1, field2, field3, totaladjustment, optcounter)
);


CREATE TABLE IF NOT EXISTS orderitems (
	orderitems_id INT8 NOT NULL,
	storeent_id INT8 NOT NULL,
	orders_id INT8 NOT NULL,
	termcond_id INT8 NULL,
	trading_id INT8 NULL,
	itemspc_id INT8 NULL,
	catentry_id INT8 NULL,
	partnum VARCHAR(64) NULL,
	shipmode_id INT8 NULL,
	ffmcenter_id INT8 NULL,
	member_id INT8 NOT NULL,
	address_id INT8 NULL,
	allocaddress_id INT8 NULL,
	price DECIMAL NOT NULL DEFAULT 0:::DECIMAL,
	lineitemtype CHAR(4) NULL,
	status CHAR NOT NULL,
	outputq_id INT8 NULL,
	inventorystatus CHAR(4) NOT NULL DEFAULT 'NALC':::STRING,
	lastcreate TIMESTAMP NULL,
	lastupdate TIMESTAMP NULL,
	fulfillmentstatus CHAR(4) NOT NULL DEFAULT 'INT':::STRING,
	lastallocupdate TIMESTAMP NULL,
	offer_id INT8 NULL,
	timereleased TIMESTAMP NULL,
	timeshipped TIMESTAMP NULL,
	currency CHAR(10) NULL,
	comments VARCHAR(254) NULL,
	totalproduct DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	quantity FLOAT8 NOT NULL,
	taxamount DECIMAL(20,5) NULL,
	totaladjustment DECIMAL(20,5) NULL DEFAULT 0:::DECIMAL,
	shiptaxamount DECIMAL(20,5) NULL,
	estavailtime TIMESTAMP NULL,
	field1 INT8 NULL,
	description VARCHAR(254) NULL,
	field2 VARCHAR(254) NULL,
	allocationgroup INT8 NULL,
	shipcharge DECIMAL(20,5) NULL,
	baseprice DECIMAL(20,5) NULL,
	basecurrency CHAR(3) NULL,
	tracknumber VARCHAR(64) NULL,
	trackdate TIMESTAMP NULL,
	prepareflags INT8 NOT NULL DEFAULT 0:::INT8,
	correlationgroup INT8 NULL,
	promisedavailtime TIMESTAMP NULL,
	shippingoffset INT8 NOT NULL DEFAULT 0:::INT8,
	neededquantity INT8 NOT NULL DEFAULT 0:::INT8,
	allocquantity INT8 NOT NULL DEFAULT 0:::INT8,
	allocffmc_id INT8 NULL,
	ordreleasenum INT8 NULL,
	configurationid VARCHAR(128) NULL,
	supplierdata VARCHAR(254) NULL,
	supplierpartnumber VARCHAR(254) NULL,
	availquantity INT8 NULL,
	isexpedited CHAR NOT NULL DEFAULT 'N':::STRING,
	optcounter INT2 NULL,
	requestedshipdate TIMESTAMP NULL,
	tiecode INT2 NULL,
	CONSTRAINT "primary" PRIMARY KEY (orderitems_id ASC),
	FAMILY "primary" (orderitems_id, storeent_id, orders_id, termcond_id, trading_id, itemspc_id, catentry_id, partnum, shipmode_id, ffmcenter_id, member_id, address_id, allocaddress_id, price, lineitemtype, status, outputq_id, inventorystatus, lastcreate, lastupdate, fulfillmentstatus, lastallocupdate, offer_id, timereleased, timeshipped, currency, comments, totalproduct, quantity, taxamount, totaladjustment, shiptaxamount, estavailtime, field1, description, field2, allocationgroup, shipcharge, baseprice, basecurrency, tracknumber, trackdate, prepareflags, correlationgroup, promisedavailtime, shippingoffset, neededquantity, allocquantity, allocffmc_id, ordreleasenum, configurationid, supplierdata, supplierpartnumber, availquantity, isexpedited, optcounter, requestedshipdate, tiecode)
);

CREATE TABLE IF NOT EXISTS address (
	address_id INT8 NOT NULL,
	addresstype CHAR(5) NULL,
	member_id INT8 NOT NULL,
	addrbook_id INT8 NOT NULL,
	orgunitname VARCHAR(128) NULL,
	field3 VARCHAR(64) NULL,
	billingcode VARCHAR(17) NULL,
	billingcodetype CHAR(2) NULL,
	status CHAR NULL,
	orgname VARCHAR(128) NULL,
	isprimary INT8 NULL,
	lastname VARCHAR(128) NULL,
	persontitle VARCHAR(50) NULL,
	firstname VARCHAR(128) NULL,
	middlename VARCHAR(128) NULL,
	businesstitle VARCHAR(128) NULL,
	phone1 VARCHAR(32) NULL,
	fax1 VARCHAR(32) NULL,
	phone2 VARCHAR(32) NULL,
	address1 VARCHAR(256) NULL,
	fax2 VARCHAR(32) NULL,
	nickname VARCHAR(254) NOT NULL,
	address2 VARCHAR(128) NULL,
	address3 VARCHAR(128) NULL,
	city VARCHAR(128) NULL,
	state VARCHAR(128) NULL,
	country VARCHAR(128) NULL,
	zipcode VARCHAR(40) NULL,
	email1 VARCHAR(256) NULL,
	email2 VARCHAR(256) NULL,
	phone1type CHAR(3) NULL,
	phone2type CHAR(3) NULL,
	publishphone1 INT8 NULL,
	publishphone2 INT8 NULL,
	bestcallingtime CHAR NULL,
	packagesuppression INT8 NULL,
	lastcreate TIMESTAMP NULL,
	officeaddress VARCHAR(128) NULL,
	selfaddress INT8 NOT NULL DEFAULT 0:::INT8,
	field1 VARCHAR(64) NULL,
	field2 VARCHAR(64) NULL,
	taxgeocode VARCHAR(254) NULL,
	shippinggeocode VARCHAR(254) NULL,
	mobilephone1 VARCHAR(32) NULL,
	mobilephone1cntry VARCHAR(128) NULL,
	optcounter INT2 NULL,
	CONSTRAINT "primary" PRIMARY KEY (address_id ASC),
	FAMILY "primary" (address_id, addresstype, member_id, addrbook_id, orgunitname, field3, billingcode, billingcodetype, status, orgname, isprimary, lastname, persontitle, firstname, middlename, businesstitle, phone1, fax1, phone2, address1, fax2, nickname, address2, address3, city, state, country, zipcode, email1, email2, phone1type, phone2type, publishphone1, publishphone2, bestcallingtime, packagesuppression, lastcreate, officeaddress, selfaddress, field1, field2, taxgeocode, shippinggeocode, mobilephone1, mobilephone1cntry, optcounter)
);

create index if not exists address_email1_idx on address (email1);

create index if not exists address_lastname_idx on address (lastname);

create index if not exists address_member_status_address_idx on address (member_id, status, selfaddress, addresstype, isprimary);

create index if not exists address_address_idx on address (addrbook_id, addresstype, isprimary, status);

create index if not exists suborders_totalproduct_idx on suborders (totalproduct);

create index if not exists suborders_orders_idx on suborders (orders_id);

create index if not exists suborders_address_idx on suborders (address_id);

create index if not exists orderitems_order_release_status_idx on orderitems (ORDERITEMS_ID,TIMERELEASED,TIMESHIPPED,INVENTORYSTATUS);

create index if not exists orderitems_orderitems_releasenum_idx on orderitems (ORDERITEMS_ID,ORDRELEASENUM,ORDERS_ID);

create index if not exists orderitems_storeent_id_idx on orderitems (STOREENT_ID);

create index if not exists orderitems_allocaddress_id_idx on orderitems (ALLOCADDRESS_ID);

create index if not exists orderitems_trading_id_idx on orderitems (TRADING_ID);

create index if not exists orderitems_termcond_id_idx on orderitems (TERMCOND_ID);

create index if not exists orderitems_shipmode_id_idx on orderitems (SHIPMODE_ID);

create index if not exists orderitems_ffmcenter_id_idx on orderitems (FFMCENTER_ID);

create index if not exists orderitems_offer_id_idx on orderitems (OFFER_ID);

create index if not exists orderitems_catentry_id_idx on orderitems (CATENTRY_ID);

create index if not exists orderitems_member_id_idx on orderitems (MEMBER_ID);

create index if not exists orderitems_address_id_idx on orderitems (ADDRESS_ID);

create index if not exists orderitems_itemspc_id_idx on orderitems (ITEMSPC_ID);

create index if not exists orderitems_allocffmc_id_idx on orderitems (ALLOCFFMC_ID);

create index if not exists orderitems_orders_storeent_idx on orderitems (ORDERS_ID,ORDRELEASENUM,STOREENT_ID,FFMCENTER_ID);

create index if not exists order_orders_id_idx on orders (ORDERS_ID);

create index if not exists order_member_store_status_id_idx on orders (MEMBER_ID,STATUS,STOREENT_ID);

create index if not exists order_address_id_idx on orders (ADDRESS_ID);

create index if not exists order_orgentity_id_idx on orders (ORGENTITY_ID);

create index if not exists order_storeent_id_idx on orders (STOREENT_ID);

create index if not exists order_editor_id_idx on orders (EDITOR_ID);

create index if not exists order_sourceid_idx on orders (SOURCEID);

create index if not exists order_buyerpo_id_idx on orders (BUYERPO_ID);

create index if not exists order_status_lastupdate_idx on orders (STATUS,LASTUPDATE);

create index if not exists order_timeplaced_idx on orders (TIMEPLACED);

ALTER TABLE IF EXISTS ORDERS ADD CONSTRAINT F_515 FOREIGN KEY ( ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID) ON DELETE CASCADE;

ALTER TABLE IF EXISTS ORDERITEMS ADD CONSTRAINT F_499 FOREIGN KEY ( ALLOCADDRESS_ID ) REFERENCES ADDRESS  ( ADDRESS_ID ) ON DELETE CASCADE;

ALTER TABLE IF EXISTS ORDERITEMS ADD CONSTRAINT F_503 FOREIGN KEY ( ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID) ON DELETE CASCADE;

ALTER TABLE IF EXISTS SUBORDERS ADD CONSTRAINT F_812 FOREIGN KEY ( ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID) ON DELETE CASCADE;

ALTER TABLE IF EXISTS SUBORDERS ADD CONSTRAINT F_813 FOREIGN KEY ( ORDERS_ID ) REFERENCES ORDERS ( ORDERS_ID) ON DELETE CASCADE;

ALTER TABLE IF EXISTS ORDERITEMS ADD CONSTRAINT F_496 FOREIGN KEY ( ORDERS_ID ) REFERENCES ORDERS ( ORDERS_ID) ON DELETE CASCADE;

-- alter table if exists orders drop constraint F_515;
