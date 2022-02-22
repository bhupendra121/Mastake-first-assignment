-- PL/SQL Anonymous Block
-- Anonymous block without name
-- Named Blocks -> CALL AGAIN AND AGAIN PROCEDURES OR FUNCTIONS
-- BLOCK BEGIN ... END;
-- SPACE BEFORE THE BEGIN KEYWORD WE CAN USE IT FOR DECLARATIONS OF VARIABLES 
--    Declare
--    BEGIN
--    
--    --    INSTRUCTIONS TO BE EXECUTED 
--    --    ANYTHING GOES WRONG YOU WILL RAISE ERROR/EXCEPTION
--    --    IF EXCEPTIONS OCCURED WE NEED TO HANDLE THE EXCEPTIONS  
--        
--    END;
SET SERVEROUTPUT ON;
BEGIN 
    DBMS_OUTPUT.put_line ('Hello World!');
    DBMS_OUTPUT.put_line (10+20);
  --  BBMS_OUTPUT.put_line ('Concatination is '+'not allowed')
  --  BBMS_OUTPUT.put_line ('Concatination is done '||'via pipes')
END;

--###########################################################################
-- PRINT MESSAGE='HELLO WORLD!' USING VARIABLE 
-- = is used for comparison operator for equality check 
-- n=10-> checking whether n has value as 10 if yes it returns true otherwise false
-- pl/sql we use ':=' as an assignment operator
--lhs:=rhs will have rhs value
--lhs=rhs indicates lhs is equal to rhs
--###########################################################################
DECLARE 
    v_message VARCHAR2(100):='HELLO WORLD!';
BEGIN
    DBMS_OUTPUT.put_line(v_message);
END;

--###########################################################################    
--    v_message   -> Naming convention
--                  -> all variables must start with v_
--                  -> must be meaningful names in camelcase if varying values
--                  -> must be meaningful names in capitalcase if constant values
--###########################################################################    
--###########################################################################                        
--   EXCEPTION HANDLING 
--  NUMBER CAN'T BE DEVIDED BY ZERO =>ERROR DEVIDE BY ZERO
--###########################################################################                        
-- without handling exception
--###########################################################################                        
    DECLARE
        v_result number:=0;
    BEGIN
            v_result:=1/0;
            
    END;
--###########################################################################                        
-- with handling exception
--###########################################################################                        
    DECLARE
        v_result number:=0;
    BEGIN
            v_result:=1/0;
            EXCEPTION
                WHEN ZERO_DIVIDE THEN
--              DBMS_OUTPUT.put_line('zero devide error');
                DBMS_OUTPUT.put_line(SQLERRM );
    END;
--###########################################################################                            
--    DBMS_OUTPUT.put_line(SQLERRM );
--    ORA-01476: divisor is equal to zero    
--    PL/SQL procedure successfully completed.
--###########################################################################                        
--    DBMS_OUTPUT.put_line('zero devide error');
--    zero devide error
--    PL/SQL procedure successfully completed.
--###########################################################################                        

--local variable
DECLARE
    l_ename VARCHAR2(50):='KING';
    l_mgr number:=0;
BEGIN
    DBMS_OUTPUT.put_line(l_ename);
    DBMS_OUTPUT.put_line(l_mgr);
END;

--local variable & default values
DECLARE
    l_ename VARCHAR2(50) DEFAULT 'KING';
    l_mgr number DEFAULT 0;
BEGIN
    DBMS_OUTPUT.put_line(l_ename);
    DBMS_OUTPUT.put_line(l_mgr);
END;

-- get ename 
SELECT ename FROM emp WHERE empno=7788;

DECLARE
    v_ename VARCHAR2(50);
BEGIN
    SELECT ename INTO v_ename FROM emp WHERE empno=7788;
    DBMS_OUTPUT.put_line(v_ename);
END;

-- ANCHORED
DECLARE
    v_ename emp.ename%type;
BEGIN
    SELECT ename INTO v_ename FROM emp WHERE empno=7788;
    DBMS_OUTPUT.put_line(v_ename);
END;

-- display the ename and sal for empno=7788
DECLARE
    v_ename emp.ename%Type;
    v_sal   emp.sal%Type;
BEGIN
    SELECT
        ename,sal 
        INTO
        v_ename,v_sal
    FROM 
        emp
    WHERE 
        empno=7788;
    DBMS_OUTPUT.PUT_LINE(v_ename|| ':' || v_sal);
END;
-- ===================================================
DECLARE 
    v_ename emp.ename%type;
    v_sal emp.sal%type;
    v_comm emp.comm%type;
    v_incentive constant emp.comm%type:=0.10;
BEGIN
        SELECT ENAME,SAL,nvl(comm,0) INTO v_ename,v_sal,v_comm 
        from emp where empno=7788;
--        v_incentive:=0.2; expression 'V_INCENTIVE' cannot be used as an assignment target
        v_sal:=v_sal+v_comm+v_incentive;
        
        DBMS_OUTPUT.PUT_line('Total Salary is '||v_sal);
END;

-- Conditional statement
--        – IF THEN
--        – IF THEN ELSE
--        – IF THEN ELSIF

--            IF condition THEN
--                statements;
--            END IF;
-- max(sal)<5000 then print salary revision is needed
DECLARE
    v_maxsal emp.sal%type;
BEGIN
    SELECT MAX(sal) INTO v_maxsal FROM emp;
    IF v_maxsal<6000 THEN
        DBMS_OUTPUT.put_line('Salary revision is needed');
    END IF;
END;

DECLARE
    v_maxsal emp.sal%type;
BEGIN
    SELECT MAX(sal) INTO v_maxsal FROM emp;
    IF v_maxsal<=4000 THEN
        DBMS_OUTPUT.put_line('Salary revision is needed');
        ELSE
        DBMS_OUTPUT.put_line('Can consider next year');
    END IF;
END;

DECLARE
    v_maxsal emp.sal%type;
BEGIN
    SELECT MAX(sal) INTO v_maxsal FROM emp;
    IF v_maxsal<3000 THEN
        DBMS_OUTPUT.put_line('Salary < 3000');
    ELSIF v_maxsal<=4000 THEN
        DBMS_OUTPUT.put_line('Salary <=4000');
    ELSE
        DBMS_OUTPUT.put_line('Ths salary is just fine');
    END IF;
END;

--Case
--        CASE selector
--        WHEN selector_value_1 THEN
--            statements_1
--        WHEN selector_value_1 THEN 
--            statement_2
--        ...
--        ELSE
--            else_statements
--        END CASE;
SELECT * FROM color;
DECLARE
    v_color color.colorcode%type;
BEGIN
    SELECT colorcode INTO v_color FROM color WHERE id=1;
    CASE v_color
        WHEN '#FF0000' THEN  DBMS_OUTPUT.put_line('RED');
        WHEN '#00FF00' THEN DBMS_OUTPUT.put_line('GREEN');
        WHEN '#0000FF' THEN DBMS_OUTPUT.put_line('BLUE');
        ELSE DBMS_OUTPUT.put_line('NO COLOR');
    END CASE;
END;

-- Numbers from 1-10
DECLARE
    v_i number:=1;
BEGIN
    LOOP
        DBMS_OUTPUT.put_line(v_i);
        v_i:=v_i+1;
        IF v_i=11 THEN
            EXIT;
        END IF;
    END LOOP;
END;

-- First 5 records from emp
SELECT *
FROM(
    SELECT * FROM emp
)
WHERE ROWNUM<=5;
DECLARE
    v_i number:=1;
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_job emp.job%TYPE;
    v_mgr emp.mgr%TYPE;
    v_hiredate emp.hiredate%TYPE;
    v_sal emp.sal%TYPE;
    v_comm emp.comm%TYPE;
    v_deptno emp.deptno%TYPE;
BEGIN
    LOOP
        SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno
        INTO v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno
        FROM emp ORDER BY empno;        
        DBMS_OUTPUT.put_line(v_empno||' '||v_ename||" "||v_job||' '||v_mgr||' '||v_hiredate||' '||v_sal||' '||v_comm||' '||v_deptno);
        v_i:=v_i+1;
        IF v_i=6 THEN
            EXIT;
        END IF;
    END LOOP;
END;

--FOR loop
-- Number from 1-10
DECLARE
    v_i NUMBER:=1;
BEGIN
    FOR v_i IN 1..10
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_i);
        END LOOP;
        
    FOR counter IN REVERSE 1..10
        LOOP
            DBMS_OUTPUT.PUT_LINE(counter);
        END LOOP;
END;

-- WHILE loop
DECLARE
    v_i number:=1;
BEGIN
    WHILE v_i<=11
    LOOP
        DBMS_OUTPUT.put_line(v_i);
        v_i:=v_i+1;
    END LOOP;
END;

