#######################################################################
-- Display the employee details (empno,ename,dname,job,sal,location).
--	emp (empno,ename,job,sal)
--	dept(dname)
--	branch(location)
--########################################################################
SELECT
    e.empno,e.ename,e.job,e.sal,d.dname,b.location
FROM
    emp e join dept d 
    on
        e.deptno=d.deptno
    join branch b
        on b.branchno=d.branchno
    Order by d.deptno;
    
--########################################################################
--  view
--########################################################################
CREATE OR REPLACE VIEW vw_empdetails
AS
SELECT
    e.empno,e.ename,e.job,e.sal,d.dname,b.location
FROM
    emp e join dept d 
    on
        e.deptno=d.deptno
    join branch b
        on b.branchno=d.branchno
    Order by d.deptno;
    
SELECT * FROM vw_empdetails;
SELECT * FROM vw_empdetails WHERE dname = 'ACCOUNTING';
SELECT empno,ename,dname FROM vw_empdetails;
SELECT empno,ename,dname FROM vw_empdetails WHERE dname='ACCOUNTING';
--#####################################################
SELECT 
    e.ename , m.ename, e.deptno
FROM
    emp e JOIN emp m
    ON e.mgr = m.empno;

CREATE VIEW vw_mgrdetails(empname,mgrname,deptno)
AS
SELECT 
    e.ename , m.ename, e.deptno
FROM
    emp e JOIN emp m
    ON e.mgr = m.empno;
    
SELECT * FROM vw_mgrdetails;
SELECT * FROM vw_mgrdetails
WHERE deptno = 30;

--########################################################################
-- VIEW IS CREATED ON SINGLE TABLE 
-- WE CAN USE DML OPERATION ON IT SUCH AS INSERT/UPDAE/DELETE
-- INCASE OF INSERT MUST HANDLE THE NULL/NOT NULL VALUES
--########################################################################
-- DISPLAY EMPNO,ENAME,JOB,SAL,COMM,DEPTNO FOR AN EMPLOYEE
-- DEPARTMENT WISE EMPLOYEE COMPLETE DETAILS RELATED TO JOB,SAL COMM ALONG WITH 
-- EMPNO AND ENAME
SELECT 
    deptno,empno,ename,job,sal,comm
    FROM
        emp
    ORDER BY deptno,empno;
    
CREATE VIEW vw_dept_wise_emp_details
(DEPTNO,EMPNO,ENAME,JOB,SAL,COMM)
AS
SELECT 
    deptno,empno,ename,job,sal,comm
    FROM
        emp
    ORDER BY deptno,empno;

SELECT * FROM vw_dept_wise_emp_details;
commit;

UPDATE vw_dept_wise_emp_details
SET comm = 0
WHERE deptno = 10;
select * from emp where deptno=10;

INSERT INTO vw_dept_wise_emp_details 
VALUES(10,2345,'JASMIN','CLERK',1300,0);
SELECT * FROM vw_dept_wise_emp_details WHERE deptno=10;


SELECT
    sal+nvl(comm,0) as totalsal
FROM
    emp;

SELECT 
    deptno, empno,ename,sal,nvl(comm,0),sal+nvl(comm,0) as totalsal
FROM
    emp;

CREATE VIEW vw_totalincome(deptno,empno,ename,sal,comm,totalsal)
AS
SELECT 
    deptno, empno,ename,sal,nvl(comm,0),sal+nvl(comm,0) as totalsal
FROM
    emp;
    
SELECT * from vw_totalincome WHERE deptno=30;

SELECT * FROM vw_totalincome
WHERE
    sal>(SELECT MIN(sal) FROM vw_totalincome);
    
-- get employees in first 5 rows
-- getting empdetails(deptno,empno,ename,job,sal) sorted on dept no and sal
    SELECT
        deptno,empno,ename,job,sal
    FROM
        emp
    ORDER BY
        deptno,sal;
-- CREATE AN INLINE VIEW TO SHOW FIRST 5 RECORDS
-- getting top 5 records based on depno and sal
SELECT *
FROM(
    SELECT
        deptno,empno,ename,job,sal
    FROM
        emp
    ORDER BY
        deptno,sal
)
WHERE
    ROWNUM<=5;
    
-- branch(branchname), dept(dname)
-- Using Lateral keyword on inline view
SELECT
    DNAME,
    BRANCHNAME
FROM 
    dept d,
    Lateral(SELECT   * 
            FROM branch b WHERE b.branchno=d.branchno)
ORDER BY
    dname;
    