create table howAbout_gyeongnam
(
	address varchar(20),
    detailedAddr varchar(10),
    nx varchar(10),
    ny varchar(10),
    lattitude varchar(20),	-- 위도
    logitude varchar(20)	-- 경도
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/gyeongnam.csv'
INTO TABLE howAbout_gyeongnam
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from howAbout_gyeongnam;