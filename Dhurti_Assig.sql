CREATE sequence customer_id
increment by 1
maxvalue 1000
minvalue 1
cache 20;

DROP SEQUENCE customer_id;

CREATE TABLE customer(
cust_id NUMBER PRIMARY KEY,
CUST_NAME varchar(50) not null,
cust_num NUMBER(10) NOT NULL ,
cust_address VARCHAR(10),
cust_dob DATE
);

DROP TABLE customer;
=========================================================
INSERT INTO CUSTOMER values ( CUSTOMER_ID.nextval,'ANIKET','9082206501','MUMBAI','18-06-2001');
INSERT INTO CUSTOMER values ( CUSTOMER_ID.nextval,'BHUPENDRA','9630731699','INDORE','8-04-1998');
INSERT INTO CUSTOMER values ( CUSTOMER_ID.nextval,'SARTHAK','9656731629','DHAR','29-05-2005');
INSERT INTO CUSTOMER values ( CUSTOMER_ID.nextval,'ADITYA','9645739699','MUMBAI','29-05-2008');
INSERT INTO CUSTOMER values ( CUSTOMER_ID.nextval,'MANAV','9632481699','PUNE','29-05-2004');
INSERT INTO CUSTOMER values ( CUSTOMER_ID.nextval,'JAY','9530731899','BHOPAL','29-05-2001');
===============================================================================================
SELECT * FROM CUSTOMER;
=============================================================================

CREATE sequence PRODUCT_ID
increment by 1
maxvalue 1000
minvalue 1
cache 20;

DROP SEQUENCE product_id;
==========================================
CREATE TABLE PRODUCT (
P_ID number primary key,
P_NAME varchar(50) not null,
P_NUM number(10) NOT NULL,
P_DESCRIPTION varchar(100),
P_PRICE number(10)
);

DROP TABLE product;

INSERT INTO PRODUCT values ( PRODUCT_ID.nextval,'TRIMER','81699','VERY EASY TO TRIM','2000');
INSERT INTO PRODUCT values ( PRODUCT_ID.nextval,'HIAR_DRYER','6731699','BEST SERVICE IN THIS RANGE','4200');
INSERT INTO PRODUCT values ( PRODUCT_ID.nextval,'FACE_WASH','9731699','SEPCIAL FOR DEY SKIN','900');
INSERT INTO PRODUCT values ( PRODUCT_ID.nextval,'LAPTOP','96381699','MULTITASKING AND FOR GAME','60000');
INSERT INTO PRODUCT values( PRODUCT_ID.nextval,'MOBILE','963899','BEST CAMERA WITH POPOP','25000');
=======================================================================================================
SELECT * FROM PRODUCT;
=======================================================================================================
CREATE sequence PURCHASE_ID
increment by 1
maxvalue 1000
minvalue 1
cache 20;

DROP SEQUENCE purchase_id;

CREATE TABLE PURCHASE (
PURCHASE_ID INT CONSTRAINT PK_PURCHASE_PURCHASE_ID PRIMARY KEY,
PURCHASE_NUM NUMBER,
CUST_ID INT CONSTRAINT FK_PURCHASE_CUST_ID REFERENCES CUSTOMER,
P_ID INT CONSTRAINT FK_PURCHASE_P_ID REFERENCES PRODUCT
);
DROP TABLE purchase;
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,30,1,2);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,31,2,4);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,32,2,5);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,33,6,2);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,34,1,5);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,35,5,2);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,36,5,1);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,37,4,4);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,38,3,4);
INSERT INTO purchase VALUES(purchase_id.NEXTVAL,39,3,3);


-- Select distinct customers from the table
SELECT
    cust_id,cust_name,cust_num,cust_dob,cust_address
FROM
    customer;

-- List the customer with the product which they bought
-- customer name - product name 
SELECT 
    p.cust_id,c.cust_name,pr.p_name
FROM
    customer c RIGHT OUTER JOIN purchase p
    ON
        c.cust_id = p.cust_id
    LEFT OUTER JOIN product pr
    ON 
        p.p_id = pr.p_id;
        
-- List the customers with the total Amount which they have
-- to pay at billing counter(sort the data in Ascending order 
-- of Billing Amount)
SELECT
    cust_name,p_price
FROM
    purchase p JOIN product pr
    ON p.p_id = pr.p_id
    JOIN customer c
    ON p.cust_id = c.cust_id;

SELECT
    cust_name, SUM(p_price) AS billing_amt
FROM
    purchase p JOIN product pr
    ON p.p_id = pr.p_id
    JOIN customer c
    ON p.cust_id = c.cust_id
GROUP BY
    cust_name;

-- List the customers whose age is more than 18 years.
SELECT *
FROM
    customer
WHERE
    ROUND(MONTHS_BETWEEN(SYSDATE,cust_dob)/12)>18;
    
-- List the customers who has not bought any product from the store.
SELECT
    cust_name
FROM
    customer c JOIN purchase p
    ON c.cust_id=p.cust_id
WHERE
    c.cust_id NOT IN (SELECT cust_id FROM purchase);

-- Find the customers whose billing amount is between 2000 to 5000.
SELECT
    cust_name, SUM(p_price)AS billing_amt
FROM
    purchase p JOIN product pr
    ON p.p_id = pr.p_id
    JOIN customer c
    ON p.cust_id = c.cust_id
GROUP BY
    cust_name
HAVING
    SUM(p_price) BETWEEN 2000 AND 5000;

-- List the products which are not purchased by anyone.
SELECT 
     DISTINCT p_name
FROM
    product pr JOIN purchase p
    ON pr.p_id=p.p_id
WHERE
    pr.p_id  NOT IN (SELECT DISTINCT p_id FROM purchase);
    
-- List the products, increased their price by 25% 
SELECT
    p_name,p_price+p_price*(25/100) AS new_price
FROM
    product;

-- find those products whose name start with 'A' and six characters in length.
SELECT
    p_name
FROM
    product
WHERE
    LENGTH(p_name)=6 AND p_name LIKE 'A%';
-- p_name LIKE 'A_____'

-- find those customers whose name ends with 'I' and third character must be 'R'. 
SELECT
    cust_name
FROM
    customer
WHERE
    cust_name LIKE '__R%I';

-- Perform join on 3 tables and display all the columns
SELECT 
c.*, pr.*, p.purchase_id, p.purchase_num
FROM
product pr JOIN purchase p
ON pr.p_id = p.p_id
JOIN customer c
ON c.cust_id = p.cust_id;
