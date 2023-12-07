================================================================================
                        MODERATE LEVEL SQL QUERIES
================================================================================

1) List the emps in the asc order of Designations of those joined after the
second half of 1981.

select * from emp1;

select * from emp1
where hiredate> '30-JUN-81'
and extract(year from hiredate)=1981
order by job;

select * from emp1
where hiredate> '30-JUN-81'
and TO_CHAR(hiredate,'YY')=81
order by job;
-------------------------------------------------------------------------------
2) Display the Empno, Ename, job, Hiredate, Exp of all Mgrs

select empno,ename,job,hiredate,round(months_between(sysdate,hiredate)/12) as exp_yrs
from emp1
where empno in (select mgr from emp1);

-------------------------------------------------------------------------------
3) List the emps along with their Exp and Daily Sal is more than Rs.100

select a.* , round(months_between(sysdate,hiredate)/12) as exp_yrs
from emp1 a
where (sal/30)>100;

-------------------------------------------------------------------------------
4) List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order 
of seniority.

select * from emp1
where hiredate in ('1-MAY-81','3-DEC-81','19-JAN-80')
order by hiredate asc;

-------------------------------------------------------------------------------
5) List the emps who are joined in the year 81.

select * from emp1;

select empno,ename,hiredate from emp1
where extract(Year from hiredate)=1980;

select empno,ename,hiredate from emp1
where To_Char(hiredate,'YYYY')=1980;
--------------------------------------------------------------------------------
6) List the emps who are joined in the month of Nov 1980.

select empno,ename,hiredate from emp1
where extract(Month from hiredate)=11;

select empno,ename,hiredate from emp1
where to_char(hiredate,'MM')=11;
--------------------------------------------------------------------------------
7) List the emps Who Annual sal ranging from 300000 and 450000.

select ename,sal,(sal*30*12) as Annual_sal from emp1
where (sal*30*12) between 300000 and 450000;

--------------------------------------------------------------------------------
8) List the emps those are having six chars and third character must be ‘r’.

select * from emp1
where length(ename)=6 and lower(ename) like '___r%';

--------------------------------------------------------------------------------
9) List the emps whose Sal is four digit number ending with Zero.

select ename,sal from emp1
where length(sal)=4 and sal like '%0';


--------------------------------------------------------------------------------
10) List the details of the emps whose Salaries more than the employee
BLAKE.

select * from emp1
where sal>(select sal from emp1 where ename='BLAKE');

--------------------------------------------------------------------------------
11) List the emps whose Jobs are same as BLAKE.

select * from emp1
where job in (select job from emp1 where ename='BLAKE');

select * from emp1 a
where job in (select b.job from emp1 b where b.ename='BLAKE' and a.empno<>b.empno); -- Exclude BLAKE itself
--------------------------------------------------------------------------------

12) List the emps who are senior to King.

SELECT * FROM EMP1 
WHERE HIREDATE <(SELECT DISTINCT HIREDATE FROM EMP1 WHERE ENAME='KING');

--------------------------------------------------------------------------------
13) List the Emps of Deptno 20 whose Jobs are same as Deptno10

SELECT * FROM EMP1
WHERE DEPTNO=20
AND JOB IN (SELECT JOB FROM EMP1 WHERE DEPTNO=10);

--------------------------------------------------------------------------------
14) List the Emps whose Sal is same as FORD or SMITH in desc order of
Sal.

SELECT * FROM EMP1
WHERE SAL IN (SELECT SAL FROM EMP1 WHERE ENAME IN ('SMITH','FORD'))
order by sal desc;

SELECT * FROM EMP1                    --Exclude 'SMITH','FORD' itself
WHERE SAL IN (SELECT a.SAL FROM EMP1 a 
             WHERE a.ENAME IN ('SMITH','FORD')
             and a.empno<>emp1.empno)
order by sal desc;

--------------------------------------------------------------------------------
14) Find the highest paid employee of sales department.

select * from emp1;
select * from dept;

select * from emp1 
where sal in (select max(a.sal) from emp1 a, dept b
              where a.deptno=b.deptno
              and b.dname='SALES');

--------------------------------------------------------------------------------
15) List the emps whose sal is greater than his managers salary
 
 select * from emp1;
 
 select * from emp1 a,emp1 b where a.mgr = b.empno and a.sal > b.sal;

--------------------------------------------------------------------------------
16) Count the No.of emps who are working as ‘Managers’(using set option).

select count(*)
from(select * from emp1 minus select * from emp1 where job not in 'MANAGER');

--------------------------------------------------------------------------------
17) Produce the following output from EMP.
SMITH (clerk)
ALLEN (Salesman)

select ename||'('||lower(job)||')' from emp1;
SELECT * FROM EMP1;
--------------------------------------------------------------------------------
18) List the emps with Hire date in format June 4, 1988.

select empno,ename,sal, to_char(hiredate,'MONTH DD,YYYY') from emp1;

--------------------------------------------------------------------------------
19) List the Enames who are retiring after 31-Dec-89 the max Job period is
20Y.

select * from emp1
where add_months(hiredate,240)>'31-DEC-89';

--------------------------------------------------------------------------------
20) List the emps who joined in the month of DEC.

select * from emp1 
where extract(month from hiredate)=12;

select * from emp1 
where to_char(hiredate,'MM')=12;
--------------------------------------------------------------------------------
21) List the emps whose Deptno is available in his Salary.

select * from emp1
where instr(sal,Deptno)>0;

--------------------------------------------------------------------------------
22) List the emps who are senior to their own manager.

select * from emp1 a,emp1 b where a.mgr = b.empno and
a.hiredate < b.hiredate;

--------------------------------------------------------------------------------
23) List the emps whose first 2 chars from Hiredate=last 2 characters of
Salary.

select * from emp1
where substr(hiredate,1,2)=substr(sal,length(sal)-1); 

--------------------------------------------------------------------------------
24) List the emps Whose 10% of Salary is equal to year of joining

select * from emp1
where extract(year from hiredate)=(0.1*sal);

select extract(year from hiredate) from emp1
where empno=0;

--------------------------------------------------------------------------------
25)List the names of depts. Where atleast 3 are working in that department.

select b.dname,count(*) from emp1 a,dept b
where a.deptno=b.deptno
group by dname
having count(*) > 3;

--------------------------------------------------------------------------------
26) List the managers whose sal is more than his employess avg salary.

select * from emp1
where empno in (select mgr from emp1)
and sal>(select avg(sal) from emp1);

--------------------------------------------------------------------------------                    

27) Produce the output of EMP table ‘EMP_AND_JOB’ for Ename and Job.

select ename ||'_AND_'||job from emp1;                    
FORD_AND_ANALYST
--------------------------------------------------------------------------------                  
28) List those emps whose Salary contains first TWO digit of their Deptno.

select * from emp1
where instr(sal, substr(deptno,1,2))>0;

--------------------------------------------------------------------------------       
29) List the name ,job, dname, location for those who are working as MGRS.
 
select * from emp1;
select * from dept;
 
select a.ename,a.job,b.dname,b.loc
from emp1 a,dept b
where a.deptno=b.deptno
and a.empno in (select mgr from emp1);
 
--------------------------------------------------------------------------------      
30) List the names of the emps who are getting the highest sal dept wise.

SELECT A.ENAME,A.SAL,A.DEPTNO,B.DNAME FROM EMP1 A,DEPT B
WHERE A.DEPTNO=B.DEPTNO
AND A.SAL IN (SELECT MAX(SAL) FROM EMP1 GROUP BY DEPTNO);

--------------------------------------------------------------------------------  
