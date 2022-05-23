create database MyShop;
use myShop;
create table supplier(SUPP_ID INT primary key, 
						SUPP_NAME varchar(20) NOT NULL, 
						SUPP_CITY varchar(20) NOT NULL, 
                        SUPP_PHONE varchar(15)NOT NULL );

create table customer(CUS_ID INT primary key, 
						CUS_NAME VARCHAR(20) NOT NULL, 
                        CUS_PHONE VARCHAR(10) NOT NULL, 
                        CUS_CITY VARCHAR(30) NOT NULL, 
                        CUS_GENDER CHAR );

create table category(CAT_ID INT primary key, 
						CAT_NAME VARCHAR(20) NOT NULL);

create table product(PRO_ID INT primary key, 
						PRO_NAME VARCHAR(20) NOT NULL DEFAULT "Dummy",
						PRO_DESC VARCHAR(60), CAT_ID INT , 
                        Foreign key (CAT_ID) references category(CAT_ID));

create table supplier_pricing(PRICING_ID INT primary key, 
						PRO_ID INT, 
                        SUPP_ID INT, 
                        SUPP_PRICE INT DEFAULT 0,
                        foreign key(PRO_ID)references product(PRO_ID),
                        foreign key(SUPP_ID) references supplier(SUPP_ID) );
                        
create table orders(ORD_ID INT primary key,
					ORD_AMOUNT INT NOT NULL,
                    ORD_DATE DATE NOT NULL,
                    CUS_ID INT ,
                    PRICING_ID INT,
                    foreign key (PRICING_ID) references supplier_pricing(PRICING_ID),
                    foreign key (CUS_ID) references customer(CUS_ID) );
                    
create table rating(RAT_ID INT primary key,
					ORD_ID INT ,
                    RAT_RATSTARS INT NOT NULL,
                    foreign key(ORD_ID) references orders(ORD_ID) );
		
insert into supplier values(1 ,'Rajesh Retails', 'Delhi', '1234567890'),
(2 ,'Appario Ltd', 'Mumbai', '2589631470'),
(3 ,'Knome Products', 'Banglore', '9785462315'),
(4 ,'Bansal Retails', 'Kochi', '8975463285'),
(5 ,'Mittal Ltd', 'Lucknow', '7898456532');

insert into customer values(1, 'AAKASH', '9999999999', 'DELHI', 'M'),
(2, 'AMAN', '9785463215', 'NOIDA', 'M'),
(3, 'NEHA', '9999999999', 'MUMBAI', 'F'),
(4, 'MEGHA', '9994562399', 'KOLKATA', 'F'),
(5, 'PULKIT', '7895999999', 'LUCKNOW', 'M');

insert into category values(1,'BOOKS'),
(2,'GAMES'),
(3,'CROCERIES'),
(4,'ELECTRONICS'),
(5,'CLOTHES');

insert into product values (1, 'GTA', 'V Windows 7 and above with i5 processor and 8GB RAM', 2),
(2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 2),
(3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4),
(4, 'OATS', 'Highly Nutritious from Nestle', 3),
(5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
(6, 'MILK', '1L Toned MIlk', 3),
(7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4),
(8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
(9, 'Project IGI', 'compatible with windows 7 and above', 2),
(10, 'Hoodie', 'Black GUCCI for 13 yrs and above ', 5),
(11, 'Rich Dad Poor Dad', 'Written by RObert Kiyosaki', 1),
(12, 'Train Your Brain', 'By Shireen Stephen', 1);

insert into supplier_pricing values(1, 1, 2, 1500),
(2, 3, 5, 30000),
(3, 5, 1,3000),
(4, 2, 3,2500),
(5, 4 ,1 ,1000);
insert into supplier_pricing values(6, 1, 2, 780),
(7, 3, 5, 789),
(8, 5, 1,30000),
(9, 2, 3,1450),
(14, 4 ,1 ,99);

insert into orders values(101, 1500, '2021-10-06', 2, 1),
(102, 1000, '2021-10-12', 3, 5),
(103, 30000, '2021-09-16', 5, 2),
(104, 1500, '2021-10-05', 1, 1),
(105, 3000, '2021-08-16', 4, 3),
(106, 1450, '2021-08-18', 1, 9),
(107, 789, '2021-09-01', 3, 7),
(108, 780, '2021-09-07', 5, 6),
(109, 3000, '2021-00-10', 5, 3),
(110, 2500, '2021-09-10', 2, 4),
(111, 1000, '2021-09-15', 4, 5),
(112, 789, '2021-09-16', 4, 7),
(113, 31000, '2021-09-16', 1, 8),
(114, 1000, '2021-09-16', 3, 5),
(115, 3000, '2021-09-16', 5, 3),
(116, 99, '2021-09-17', 2, 14);

insert into rating values(1,101,4), (2,102,3), (3,103,1), (4,104,2), (5,105,4), (6,106,3), (7,107,4), (8,108,4), (9,109,3), (10,110,5), 
(11,111,3), (12,112,4), (13,113,2), (14,114,1),(15,115,1),(16,116,0);

#3
select CUS_GENDER , count(CUS_GENDER ) from customer where CUS_ID in (SELECT CUS_ID from orders where ORD_AMOUNT >=3000) group by CUS_GENDER;

#4
select o.*,p.pro_name from orders o
join supplier_pricing sp on o.pricing_id=sp.pricing_id
join product p on sp.pro_id=p.pro_id
where o.cus_id=2;

#5
select s.* from supplier s
join supplier_pricing sp
on s.SUPP_ID=sp.SUPP_ID group by sp.SUPP_ID;

#6
select c.cat_id, c. cat_name, p.pro_name, min(s.SUPP_PRICE) as least_expensive from supplier_pricing s
join product p on s.pro_id=p.pro_id
join category c on p.cat_id=c.cat_id group by c.cat_id;

#7
select pro_id, pro_name from product where pro_id in (select pro_id from supplier_pricing sp where sp.pricing_id in(select pricing_id from orders o where ord_date>'2021-10-05')); 

#8
select CUS_NAME, CUS_GENDER from customer where CUS_NAME like 'a%' or CUS_NAME like '%a';

#9
select s.SUPP_ID, s.SUPP_NAME, r.RAT_RATSTARS, 
CASE
	WHEN r.RAT_RATSTARS=5 THEN 'Excellent Service'
    WHEN r.RAT_RATSTARS>4 THEN 'Good Service'
    WHEN r.RAT_RATSTARS>2 THEN 'Average Service'
    ELSE 'Poor Service'
END as Type_of_Service from supplier s
join supplier_pricing sp on s.SUPP_ID=sp.SUPP_ID
join orders o on sp.PRICING_ID=o.PRICING_ID
join rating r on o.ORD_ID=r.ORD_ID; 



