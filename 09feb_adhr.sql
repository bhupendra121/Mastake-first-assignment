SELECT * FROM c##aduser.color;
-- Public Synonym
CREATE PUBLIC SYNONYM colors FOR c##aduser.color;
SELECT * FROM colors;

--  Non Public Synonym
CREATE SYNONYM syn_emp_dummy FOR c##aduser.emp_dummy;
select * from emp_dummy;
INSERT INTO syn_emp_dummy VALUES(1234,'ANIKET','MANAGER',7839,to_date('18-06-81','dd-mm-yy'),3000,500,10);
select * from syn_emp_dummy;

-- DROP SYNONYM
DROP SYNONYM syn_emp_dummy FORCE;

-- Sequence
CREATE SEQUENCE product_id
INCREMENT BY 1
MAXVALUE 1000
MINVALUE 1
CACHE 20;

CREATE TABLE product(
pid NUMBER PRIMARY KEY,
pname VARCHAR(50) NOT NULL
);

INSERT INTO product VALUES(product_id.NEXTVAL,'pepsi 500ml');
INSERT INTO product VALUES(product_id.NEXTVAL,'pepsi 500ml');
INSERT INTO product VALUES(product_id.NEXTVAL,'pepsi 500ml');
INSERT INTO product VALUES(product_id.NEXTVAL,'pepsi 500ml');
INSERT INTO product VALUES(product_id.NEXTVAL,'pepsi 500ml');

SELECT * FROM product;

-- ALTER SEQUENCE
ALTER SEQUENCE product MAXVALUE 10000;

--DROP SEQUENCE
DROP SEQUENCE product_id;
DROP TABLE product;

-- ROLE : Group of privileges
-- part 1 Master Data Management ROLE called c##mdm
CREATE ROLE c##mdm; -- WITHOUT PASSWORD
-- part 2 
GRANT SELECT,INSERT,UPDATE,DELETE ON emp to c##mdm;
GRANT SELECT,INSERT,UPDATE,DELETE ON dept to c##mdm;
GRANT SELECT,INSERT,UPDATE,DELETE ON branch to c##mdm;

CREATE USER c##alice IDENTIFIED BY alice;
-- part 3 assign the role to the user 
GRANT c##mdm TO c##alice;
GRANT CREATE SESSION TO c##alice;
-- open sql plus
-- username: c##alice
-- password: alice
-- SELECT * FROM c##aduser.emp;
-- SET ROLE c##mdm;
-- CREATE SYNONYM emp FOR c##aduser.emp;
-- the above statement will through an error since
-- we have not assigned the CREATE role to c##mdm
-- SELECT * FROM SESSION_ROLES; this will return the roles applied
-- ------------------------
CREATE ROLE c##reader IDENTIFIED BY reader;
GRANT SELECT ON emp to c##reader;
GRANT SELECT ON dept to c##reader;
GRANT SELECT ON branch to c##reader;
--DROP ROLE c##jasmine;

CREATE USER c##user IDENTIFIED BY user;
GRANT c##reader TO c##user;
GRANT CREATE SESSION TO c##user;
-- On SQL PLUS:
-- CONNECT c##user/user;
-- SET ROLE c##reader IDENTIFIED BY reader;
-- SELECT * FROM c##aduser.dept;
-- if we 'SET ROLE c##mdm' whlile connected to c##user
-- OR
-- if we 'SET ROLE c##reader IDENTIFIED BY READER'
-- whlile connected to c##alice
-- then it will throw error as role not granted
-- for that:
GRANT c##reader TO c##alice;
GRANT c##mdm TO c##user;
-- then in SQL PLUS
-- SET ROLE c##reader IDENTIFIED BY reader, c##mdm;


-- DB USER VIEW -> ALL USERS 
SELECT
    username,profile
FROM
    dba_users;

-- database link
COMMIT;