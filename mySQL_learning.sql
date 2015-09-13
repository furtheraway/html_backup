
-- installation: http://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/index.html--repo-qg-apt-replacing
-- a quick reference from 3wschool:
http://www.w3schools.com/sql/sql_quickref.asp

-- check mysql service status:
    sudo service mysql status
    sudo service mysql stop
    sudo service mysql start



-- start mysql interactively: 
    abc@abc-Notebook:~/Dropbox/html$ mysql -u root -p
    Enter password: aj...*

    mysql -u user -h hostname -p
    mysql -h host -u user -p menagerie(name of a database you want to use directly)

    \c -- abandon
    \q l

-- examples:
  112  mysql -u sudhir -pmyDB007 -h sdev1.ams.sunysb.edu
  114  mysql -u sudhir -pmyDB007 -h yyao@sdev1.ams.sunysb.edu
  115  mysql --help
  118  mysql -u root -p
  121  mysql -u root -p immunoglobulin



-- system information: 
    select version(), current_date();
    select now(), user();


-- create and change databases:
    select database(); -- To find out which database is currently selected
    show databases;
    create database test;
    use test; 
    SHOW TABLES;



-- create tables:
    CREATE TABLE pet (
        name VARCHAR(20) NOT NULL,
        owner VARCHAR(20) DEFAULT 'yy',
        species VARCHAR(20),
        sex CHAR(1),
        birth DATE,
        death DATE
        CHECK (ID > 0));

    CREATE TABLE shop (
        article INT(4) UNSIGNED ZEROFILL DEFAULT '0000' NOT NULL,
        dealer  CHAR(20)                 DEFAULT ''     NOT NULL,
        price   DOUBLE(16,2)             DEFAULT '0.00' NOT NULL,
        PRIMARY KEY(article, dealer));

    
    CREATE TABLE person (
	    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	    name CHAR(60) NOT NULL,
	    PRIMARY KEY (id));
	-- due to auto_increment, null in the below insert will be replaced.
	INSERT INTO person VALUES (NULL, 'Antonio Paz');


	CREATE TABLE animals (
	     id MEDIUMINT NOT NULL AUTO_INCREMENT,
	     name CHAR(30) NOT NULL,
	     PRIMARY KEY (id));
	INSERT INTO animals (name) VALUES
	    ('dog'),('cat'),('penguin'),
	    ('lax'),('whale'),('ostrich');
	SELECT * FROM animals;

	--An index can be created in a table to find data more quickly and efficiently. The users cannot see the indexes, they are just used to speed up searches/queries. Note: Updating a table with indexes takes more time than updating a table without (because the indexes also need an update). So you should only create indexes on columns (and tables) that will be frequently searched against.
	CREATE INDEX index_name 
	ON table_name (column_name);
	-- DROP INDEX Syntax for MySQL:
	ALTER TABLE table_name DROP INDEX index_name


	--To start with an AUTO_INCREMENT value other than 1, set that value with CREATE TABLE or ALTER TABLE, like this:
	ALTER TABLE tbl AUTO_INCREMENT = 100;


    SHOW CREATE TABLE tbl_name  -- hows the CREATE TABLE statement that creates the named table.

    DESCRIBE pet;  -- pet here is a table, not a database


-- delete rows from a table
	DELETE FROM table_name
	WHERE some_column=some_value; 
	-- delete the all rows without deleting the whole table
	DELETE FROM table_name;
	DELETE * FROM table_name;

	-- The DROP TABLE statement is used to delete a table.
	DROP TABLE table_name

-- Alter a table
	-- To add a column in a table, use the following syntax:
	ALTER TABLE table_name
	ADD column_name datatype;

	-- To delete a column in a table, use the following syntax (notice that some database systems don't allow deleting a column):
	ALTER TABLE table_name
	DROP COLUMN column_name;

	--To change the data type of a column in a table
	ALTER TABLE table_name
	MODIFY COLUMN column_name datatype;



-- load text file 
    LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet;
    LOAD DATA LOCAL INFILE '/home/john/pet.txt' INTO TABLE pet fields terminated by ' ';
        input file format: (tab separated, \N is for NULL)
        Whistler    Gwen    bird    \N  1997-12-09  \N



-- insert data entries:
	INSERT INTO table_name
		VALUES (value1,value2,value3,...);
	
	INSERT INTO table_name (column1,column2,column3,...)
		VALUES (value1,value2,value3,...);

    INSERT INTO pet
        VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL);

    INSERT INTO shop VALUES
        (1,'A',3.45),(1,'B',3.99),(2,'A',10.99),(3,'B',1.45),
        (3,'C',1.69),(3,'D',1.25),(4,'D',19.95);
    -- use the default values
	insert into t2 values (default,'a'),(4,default);




-- query - SELECT with where
    SELECT name, birth FROM pet LIMIT 1;
    SELECT * FROM pet WHERE birth >= '1998-1-1';
    SELECT * FROM pet WHERE (species = 'cat' AND sex = 'm') OR (species = 'dog' AND sex = 'f');
    -- <> is not equal to 

    
    SELECT DISTINCT owner FROM pet;

    -- group by and having
	select *, count(*) from (SELECT distinct * FROM t1) as dis group by year, month;
 	SELECT  *, count(*) FROM t1 group by t1.year, t1.month, t1.day;
    SELECT  *, count(*) FROM t1 group by t1.year, t1.month, t1.day having count(*)>1;

    -- in a set
	SELECT * FROM Customers
	WHERE City IN ('Paris','London');
	-- between 
	SELECT column_name(s)
	FROM table_name
	WHERE column_name BETWEEN value1 AND value2;



    -- You can force a case-sensitive sort for a column by using BINARY like so: ORDER BY BINARY col_name. 
    
    -- order by certain field:
    SELECT name, birth FROM pet ORDER BY birth [ASC|DESC]; -- desc means decrease
    SELECT name, species, birth FROM pet ORDER BY species ASC, birth DESC;




    -- Pattern Matching 
    “_” to match any single character and 
    “%” to match an arbitrary number of characters (including zero characters).
    [charlist] 	Sets and ranges of characters to match
	[^charlist] or [!charlist] 	Matches only a character NOT specified within the brackets 

    SELECT * FROM pet WHERE name LIKE 'b%';
    SELECT * FROM pet WHERE name LIKE '%fy';
    SELECT * FROM pet WHERE name LIKE '_____';
    SELECT * FROM pet WHERE name NOTLIKE '_____';
	SELECT * FROM Customers WHERE City LIKE '[a-c]%';

    -- with regular expression
    SELECT * FROM pet WHERE name REGEXP '^b';
    SELECT * FROM pet WHERE name REGEXP 'fy$';
    SELECT * FROM pet WHERE name REGEXP 'w'; -- a regular expression pattern matches if it occurs anywhere in the value
    SELECT * FROM pet WHERE name REGEXP '^.{5}$';


    -- group by, factorization
    SELECT article, MAX(price) AS price
        FROM   shop
        GROUP BY article;



    -- count:
    SELECT COUNT(*) FROM pet;
    SELECT sex, COUNT(*) FROM pet GROUP BY sex;
    SELECT owner, COUNT(*) FROM pet GROUP BY owner;
    SELECT species, COUNT(*) FROM pet GROUP BY species;
    SELECT species, sex, COUNT(*) FROM pet GROUP BY species, sex;


	-- SQL Alias Syntax for Columns
	SELECT column_name AS alias_name
	FROM table_name;
	-- SQL Alias Syntax for Tables
	SELECT column_name(s)
	FROM table_name AS alias_name; 

-- use multiple tables, join, inner/left/right join:
    -- inner join or just join
    select pet.name, event.* from pet  -- pet with event.
        inner join event on pet.name=event.name;
    
    SELECT pet.name,(YEAR(date)-YEAR(birth)) - (RIGHT(date,5)<RIGHT(birth,5)) AS age, remark
        FROM pet INNER JOIN event
          ON pet.name = event.name
        WHERE event.type = 'litter';

    SELECT p1.name, p1.sex, p2.name, p2.sex, p1.species -- same table, match maker for pets
        FROM pet AS p1 INNER JOIN pet AS p2
          ON p1.species = p2.species AND p1.sex = 'f' AND p2.sex = 'm';
    SELECT p1.name, p1.sex, p2.name, p2.sex, p1.species 
        FROM ((pet AS p1) INNER JOIN (pet AS p2) 
          ON p1.species = p2.species AND p1.sex = 'f' AND p2.sex = 'm');


    -- same table, highest price for one article
    -- inner join (uncorrelated subquery)
	    SELECT s1.article, dealer, s1.price 
	    FROM shop s1
	    JOIN (
	    SELECT article, MAX(price) AS price
	    FROM shop
	    GROUP BY article) AS s2
	    ON s1.article = s2.article AND s1.price = s2.price;

    -- left join
		SELECT s1.article, s1.dealer, s1.price
		FROM shop s1
		LEFT JOIN shop s2 ON s1.article = s2.article AND s1.price < s2.price
		WHERE s2.article IS NULL;

	-- correlated subquery
		SELECT article, dealer, price
		FROM   shop s1
		WHERE  price=(SELECT MAX(s2.price)
        FROM shop s2
        WHERE s1.article = s2.article);

	-- union, combines the rows
	SELECT column_name(s) FROM table1
	UNION [ALL] -- all will keep duplicates
	SELECT column_name(s) FROM table2;

-- Copy only the columns we want into the NEW table:
	SELECT column_name(s)
	INTO newtable [IN externaldb]
	FROM table1;
	--The new table will be created with the column-names and types as defined in the SELECT statement. You can apply new names using the AS clause.

	--repo-qg-apt-replacingNSERT INTO SELECT statement copies data from one table and inserts it into an existing table.
	INSERT INTO table2
	(column_name(s))
	SELECT column_name(s)
	FROM table1;

-- change, modify, update
	UPDATE table_name
		SET column1=value1,column2=value2,...
		WHERE some_column=some_value;

    UPDATE pet SET birth = '1989-08-31' WHERE name = 'Bowser';
    update shop set price=4.99 where (article=0003 and dealer='B');



-- useful functions:
	MAX(); Avg(); Sum(); etc.
    SELECT article, dealer, price
    FROM   shop
    WHERE  price=(SELECT MAX(price) FROM shop);


	LAST_INSERT_ID() --Value of the AUTOINCREMENT column for the last INSERT 

    SELECT name, birth, CURDATE(),
        TIMESTAMPDIFF(YEAR,birth,CURDATE()) AS age
        FROM pet ORDER BY age;

    SELECT name, birth, MONTH(birth) FROM pet;
    SELECT name, birth FROM pet WHERE MONTH(birth) = 5;

    SELECT name, birth FROM pet
        WHERE MONTH(birth) = MOD(MONTH(CURDATE()), 12) + 1;


    -- user-defined variables
	    SELECT @min_price:=MIN(price),@max_price:=MAX(price) FROM shop;
		select @min_price, @max_price;
		SELECT * FROM shop WHERE price=@min_price OR price=@max_price;



-- 3.5 Using mysql in Batch Mode
    shell> mysql < batch-file
    C:\> mysql -e "source batch-file" -- windows
    shell> mysql -h host -u user -p < batch-file
    Enter password: ********
    mysql -t < batch-file -- If you want to get the interactive output format in batch mode. 
    mysql -vvv < batch-file -- To echo to the output the commands that are executed. 
 
    -- You can also use scripts from the mysql prompt by using the source command or \. command:
    mysql> source filename;
    mysql> \. filename


--Back up and restore: mysqldump is used in a terminal $
	$mysqldump --opt -u [uname] -p[pass] [dbname] > [backupfile.sql]
	$ mysqldump -u root -p DB_name > tut_backup.sql
	$ mysqldump -u root -p DB_name table1 table2 > tut_backup.sql
	$ mysqldump -u root -p -B Tutorials Articles Comments > content_backup.sql -- or replace -A with --databases
	$ mysqldump -u root -p --all-databases > alldb_backup.sql 
	
	--no-data: Dumps only the database structure, not the contents. 

	$ mysqldump -u [uname] -p[pass] [dbname] | gzip -9 > [backupfile.sql.gz]
	$ gunzip [backupfile.sql.gz] -- extract zip file

	-- restore:
	http://dev.mysql.com/doc/refman/5.6/en/reloading-sql-format-dumps.html
	$ mysql -u [uname] -p[pass] [db_to_restore] < [backupfile.sql]
	$ mysql -u root -p Tutorials < tut_backup.sql
	gunzip < [backupfile.sql.gz] | mysql -u [uname] -p[pass] [dbname]




-- Suppose that you want to call yours menagerie. The administrator needs to execute a command like this: 
    GRANT ALL ON menagerie.* TO 'your_mysql_name'@'your_client_host';


