------------Table creation---------

create table inventory(
Typeofsales char(20),
Patient_ID Bigint,
Specialisation varchar(20),
Dept varchar(20),
Dateofbill date,
Quantity int,
ReturnQuantity int,
Final_Cost Numeric,
Final_Sales Numeric,
RtnMRP Numeric,
Formulation varchar(40),
DrugName varchar(250),
SubCat varchar(250),
SubCat1 varchar(250)
);
create table inventory_copy AS select * from inventory;
select * from inventory_copy;

                            ------ preprocessing------
						
select * from inventory limit 8;
select distinct Dept from inventory;
select count(distinct Specialisation) from inventory;

-----Handling null values-----
select count(*) from inventory where DrugName is null and Formulation is null;
Delete from inventory where DrugName is null and Formulation is null;
select count(*) from inventory where DrugName is null and SubCat is null and SubCat1 is null;
Delete from inventory where DrugName is null and SubCat is null and SubCat1 is null;
select * from inventory;
------after deleting null values dataset-------
select Patient_ID, count(Patient_ID) from inventory
group by Patient_ID having count(Patient_ID)>1 order by count(Patient_ID) desc;
select DrugName from inventory where Final_Sales = '0';

select sum(Final_Sales) as tot_sales,DrugName from inventory
group by DrugName order by tot_sales desc;

select sum(Final_Sales) as tot_sales,Dept from inventory 
group by Dept order by tot_sales desc;

select count(*) as tot_count,SubCat from inventory where TypeofSales= 'Return' 
group by SubCat order by tot_count desc;

select count(*) as tot_count,DrugName from inventory where TypeofSales= 'Return' 
group by DrugName order by tot_count desc;

------Univariate analysis -------

select avg(Quantity) as meanQ,
min(Quantity) as minimumQ,
max(Quantity) as maxmimumQ,
stddev(Quantity) as stdQ
from inventory;

-----Bivariate analysis-------

select Specialisation,avg(Final_Sales) as tot_sales
from inventory group by Specialisation order by tot_sales desc;

select corr(Final_Sales,Quantity) As correlation_coefficient
from inventory;

------Multivariate analysis------

select corr(Final_Sales,Quantity) As corr1,
corr(Final_Sales,Final_Cost) As corr2,
corr(Quantity,Final_Cost) As corr3
from inventory;

------skewness and kurtosis-------

select 
 (sum(pow(Quantity-meanQ,3))/(count(Quantity)*pow(stddev(Quantity),3))) as skewness,
 (sum(pow(Quantity-meanQ,4))/(count(Quantity)*pow(stddev(Quantity),4))) as kurtosis
from inventory,
(select avg(Quantity) as meanq from inventory) as subquery;

--------Analysis---------

SELECT 
    Dateofbill AS purchase_date,
    SUM(Final_Sales) AS tot_sales,
    SUM(Quantity) AS tot_quantity,
    SUM(ReturnQuantity) AS tot_returned_quantity,
	count(Patient_ID) As tot_Patient
FROM inventory
GROUP BY Dateofbill
ORDER BY Dateofbill;












