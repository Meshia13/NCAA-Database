--NCAA Database created by Carmeshia Lazzana
--
--This database features the creation of 5 tables. Each table is created based upon an
--csv file that is imported into Microsoft SQL Server Management Studio. 
 
 ----Creation of fact table and dimension table from star schema

--Dropping database NCAA in case database is already created
--drop database NCAA

--Creating database/schema titled NCAA
create database NCAA

--Using the database that was created
use NCAA;

--Dropping tables in case they exists
drop table if exists equity_in_athletics;
drop table if exists collegiate_athletics_financial_info;
drop table if exists mini_wage;
drop table if exists schools;
drop table if exists total_coa;

---------------------------------------------------------------------------

--------------------------------minimum wage table------------------------
--Creating table mini_wage for databases
create table mini_wage (
	year int not null,
	state nvarchar(50) not null,
	state_min_wage decimal(15,2),
	fed_min_wage decimal(15,2),
	state_year nvarchar(100) not null
	);

--insering data from csv file 'mini_wage_final' into table created, concating columns 'state' and 
--'year' to create a primary key

insert into mini_wage (year, state, state_min_wage, fed_min_wage, state_year)
select year, state, state_min_wage, fed_min_wage, CONCAT(state,year) from mini_wage_final;

select * from mini_wage

--adding constraint, making state_year the primary key
alter table mini_wage 
add constraint miniwage_pkey primary key(state_year);

-------------------------------------------------------------------------------

---------------------------------schools table---------------------------------
create table schools (
	unitid int not null,
	institution nvarchar(100) not null,
	titleiv nvarchar(50) not null,
	constraint schools_pkey primary key(unitid)
);


--insering data from csv file 'school' into table created

insert into schools (unitid, institution, titleiv)
select unitid, institution, titleiv from school;

select * from schools;

-- renaming unitid and institution columns
exec sp_rename 'schools.unitid', 'ipeds_id'
exec sp_rename 'schools.institution', 'institution_name'

-------------------------------------------------------------------------------------------------------

-------------------------------------equity_in_athletics table-----------------------------------------
create table equity_in_athletics (
	ipedsID_year VARCHAR(100) not null,
	ipeds_id INT not null, 
	institution_name VARCHAR(100) not null, 
	state VARCHAR(100) not null, 
	year int not null, 
	athletic_aid_men DECIMAL(18,2), 
	athletic_aid_women DECIMAL(18,2), 
	athletic_aid_coed DECIMAL(18,2), 
	total_athletic_aid DECIMAL(18,2), 
	total_student_athletes_men DECIMAL(18,2), 
	total_student_athletes_women DECIMAL(18,2), 
	total_student_athletes DECIMAL(18,2), 
	total_student_athletes_menbskball DECIMAL(18,2), 
	total_student_athletes_menftball DECIMAL(18,2), 
	total_student_athletes_wmbskball DECIMAL(18,2), 
	total_mnbskball_rev DECIMAL(18,2), 
	total_mnbskball_exp DECIMAL(18,2), 
	mnbskball_net_profit DECIMAL(18,2), 
	total_wmbskball_rev DECIMAL(18,2), 
	total_wmbskball_exp DECIMAL(18,2), 
	wmbskball_net_profit DECIMAL(18,2),
	total_menftball_rev DECIMAL(18,2), 
	total_menftball_exp DECIMAL(18,2), 
	menftball_net_profit DECIMAL(18,2), 
	total_school_rev DECIMAL(18,2), 
	total_school_exp DECIMAL(18,2), 
	school_net_profit DECIMAL(18,2),
	CONSTRAINT equity_in_athletics_pkey PRIMARY KEY(ipedsID_year)
);

--insering data from csv file 'Equity_in_Athletics_Data' into table created, concating columns 'ipeds_id' and 
--'year'  to create primary key

insert into equity_in_athletics (ipedsID_year, ipeds_id, institution_name, state, year,athletic_aid_men, 
	athletic_aid_women, athletic_aid_coed, total_athletic_aid, total_student_athletes_men, total_student_athletes_women, 
	total_student_athletes, total_student_athletes_menbskball, total_student_athletes_menftball, total_student_athletes_wmbskball, 
	total_mnbskball_rev, total_mnbskball_exp, mnbskball_net_profit, total_wmbskball_rev, total_wmbskball_exp, 
	wmbskball_net_profit, total_menftball_rev, total_menftball_exp, menftball_net_profit,total_school_rev, total_school_exp, school_net_profit)

select CONCAT(ipeds_id,year), ipeds_id, institution_name, state, year,athletic_aid_men, 
	athletic_aid_women, athletic_aid_coed, total_athletic_aid, total_student_athletes_men, total_student_athletes_women, 
	total_student_athletes, total_student_athletes_menbskball, total_student_athletes_menftball, total_student_athletes_wmbskball, 
	total_mnbskball_rev, total_mnbskball_exp, mnbskball_net_profit, total_wmbskball_rev, total_wmbskball_exp, 
	wmbskball_net_profit, total_menftball_rev, total_menftball_exp, menftball_net_profit,total_school_rev, total_school_exp, school_net_profit
from Equity_in_Athletics_Data;

select * from equity_in_athletics

-------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------collegiate_athletics_financial_info---------------------------------------------------------------------------------
create table collegiate_athletics_financial_info(
	ipedsID_year VARCHAR(100) not null,
	institution_name VARCHAR(100) not null,
	ipeds_id INT not null,
	year INT not null,
	total_expenses DECIMAL(18,2),
	medical DECIMAL(18,2),
	game_travel_expense DECIMAL(18,2),
	equipment DECIMAL(18,2),
	coaches_compensation DECIMAL(18,2),
	student_aid DECIMAL(18,2),
	total_revenues DECIMAL(18,2),
	corp_sponsor_advertising_licensing DECIMAL(18,2),
	donor_contrib DECIMAL(18,2),
	CONSTRAINT collegiatet_pkey PRIMARY KEY(ipedsID_year)
);

--insering data from csv file 'custom_report_data' into table created, concating columns 'ipeds_id' and 
--'year' to create primary key 

insert into collegiate_athletics_financial_info(ipedsID_year, institution_name, ipeds_id, year, total_expenses, medical,
	game_travel_expense, equipment, coaches_compensation, student_aid, total_revenues, corp_sponsor_advertising_licensing, 
	donor_contrib)

select CONCAT(ipeds_id,year), institution_name, ipeds_id, year, total_expenses, medical, game_travel_expense, equipment, coaches_compensation, 
	   student_aid, total_revenues, corp_sponsor_advertising_licensing, donor_contrib
from custom_report_data;

select * from collegiate_athletics_financial_info;


-------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------totalCOA---------------------------------------------------------------------------------

CREATE TABLE total_coa(
  ipedsId_year VARCHAR(100) NOT NULL,
  ipeds_id INT not null,
  institution_name VARCHAR(100),
  state VARCHAR(100) not null,
  year INT not null,
  in_state_off_campus_family DECIMAL(18,2),
  in_state_off_campus_single  DECIMAL(18,2),
  in_state_on_campus  DECIMAL(18,2),
  out_of_state_off_campus_family  DECIMAL(18,2),
  out_of_state_off_campus_single  DECIMAL(18,2),
  out_of_state_on_campus  DECIMAL(18,2),
  session VARCHAR(100) NOT NULL,
  CONSTRAINT total_cost_of_attendance_pkey PRIMARY KEY(ipedsID_year)
);

--insering data from csv file 'totalCOA' into table created, concating columns 'ipeds_id' and 
--'year' to create primary key 

INSERT INTO total_coa(ipedsId_year,ipeds_id,institution_name,state,year,in_state_off_campus_family,in_state_off_campus_single,
	in_state_on_campus,out_of_state_off_campus_family,out_of_state_off_campus_single,out_of_state_on_campus,session)

SELECT CONCAT(ipeds_id, year), ipeds_id,institution_name, state,year,in_state_off_campus_family,in_state_off_campus_single,
	in_state_on_campus,out_of_state_off_campus_family,out_of_state_off_campus_single,out_of_state_on_campus,session
FROM totalCOA;

SELECT * from total_coa;
---------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

-----CREATING A FACT TABLE AND DIMENSION TABLE FOR STAR SCHEMA-------------------
----

-----FACT TABLE------
DROP TABLE fact_table;

CREATE TABLE fact_table (
  unique_id integer NOT NULL IDENTITY(1,1),
  ipeds_id integer,
  year integer,
  session character varying(256),
  state character varying(256),
  total_expenses numeric(18,2), 
  total_revenues numeric(18,2), 
  total_student_athletes numeric(18,2),
  coa_in_state_off_campus_family numeric(18,2),  
  coa_in_state_off_campus_single numeric(18,2),
  coa_in_state_on_campus numeric(18,2),
  coa_out_of_state_off_campus_family numeric(18,2),
  coa_out_of_state_off_campus_single numeric(18,2),
  coa_out_of_state_on_campus numeric(18,2),
  CONSTRAINT fact_table_pkey PRIMARY KEY(unique_id));
   
 INSERT INTO fact_table(
  ipeds_id, year, session,state,total_expenses, total_revenues, total_student_athletes, coa_in_state_off_campus_family,  
  coa_in_state_off_campus_single, coa_in_state_on_campus, coa_out_of_state_off_campus_family, coa_out_of_state_off_campus_single,
  coa_out_of_state_on_campus)

SELECT 
total_coa.ipeds_id,
total_coa.year,
  session,
  total_coa.state,
  total_expenses,
  total_revenues,
 equity_in_athletics.total_student_athletes, 
  in_state_off_campus_family AS coa_in_state_off_campus_family,  
  in_state_off_campus_single AS coa_in_state_off_campus_single,
  in_state_on_campus AS coa_in_state_on_campus,
  out_of_state_off_campus_family AS coa_out_of_state_off_campus_family,
  out_of_state_off_campus_single AS coa_out_of_state_off_campus_single, 
  out_of_state_on_campus AS coa_out_of_state_on_campus
  FROM equity_in_athletics 
  JOIN total_coa ON 
 equity_in_athletics.ipedsId_year = total_coa.ipedsId_year
  JOIN collegiate_athletics_financial_info ON 
 equity_in_athletics.ipedsId_year = collegiate_athletics_financial_info.ipedsId_year;

----ADDING A COLUMN TO THE TABLE BY USING CONCAT TO CREATE THE NEW COLUMN----
ALTER TABLE fact_table
ADD  state_year character varying(256);
 
UPDATE fact_table
 SET state_year = CONCAT(state, year);
 
SELECT * from fact_table
 
 ------------DIMENSION TABLE

drop table dim_schools_sessions;

 CREATE TABLE dim_schools_sessions(
 year integer,
 session VARCHAR(100) NOT NULL);

INSERT INTO dim_schools_sessions(year,session)
 SELECT year,session
 FROM totalCOA;

SELECT * FROM dim_schools_sessions;
