CREATE TABLE World (
  name VARCHAR(45) PRIMARY KEY,
  Continent VARCHAR(45) NOT NULL,
  Area VARCHAR(20) NOT NULL
  );
  DESCRIBE world;
  ALTER TABLE world ADD Population DECIMAL(10,2) NOT NULL;
  ALTER TABLE world ADD GDP DECIMAL(15,2) NOT NULL;
DESCRIBE world;
  USE  world;
  INSERT INTO world VALUES ('Afghanistan','Asia',652230,25500100,20343000000);
  INSERT INTO world VALUES ('Albania','Europe',28748,2831741,12960000000);
  INSERT INTO world VALUES ('Algeria','Africa',2381741,37100000,188681000000);
  INSERT INTO world VALUES ('Andorra','Europe',468,78115,3712000000);
  INSERT INTO world VALUES ('Angola','Africa',1246700,20609294,100990000000);
 -- The example uses a WHERE clause to show the population of 'France'. Note that strings (pieces of text that are data) should be in 'single quotes'; 
  SELECT population 
  FROM world 
  WHERE name='Angola';
  
  -- 2. Checking a list The word IN allows us to check if an item is in a list. The example shows the name and population for the countries 'Brazil', 'Russia', 'India' and 'China';
  SELECT name, population
  FROM world
  WHERE name in ('Afghanistan','Algeria','Andorra');
  -- * mistake: always set a right order (name/population); always put a prime '  ' for names;
  
  -- 3. Which countries are not too small and not too big? BETWEEN allows range checking (range specified is inclusive of boundary values). Modify it to show the country and the area for countries with an area between 200,000 and 250,000;
  SELECT name, area
  FROM world
  WHERE area between '200000' and '250000';
   -- * mistake: always put a prime '  ' for numbers; 
  
