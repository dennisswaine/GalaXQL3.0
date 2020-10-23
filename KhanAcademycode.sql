1. Create your own store! Your store should sell one type of things, like clothing or bikes, whatever you want your store to specialize in. 
You should have a table for all the items in your store, and at least 5 columns for the kind of data you think you'd need to store. 
You should sell at least 15 items, and use select statements to order your items by price and show at least one statistic about the items.

CREATE TABLE liquor_store (id INTEGER PRIMARY KEY,  name TEXT, quantity INTEGER, price NUMERIC, brand TEXT); 

INSERT INTO liquor_store VALUES (1, 'Vodka', 100, 14.99, 'Smirnoff');
INSERT INTO liquor_store VALUES (2, 'Vodka', 24, 9.99, 'Glens');
INSERT INTO liquor_store VALUES (3, 'Vodka', 53, 39.99, 'Ciroc');
INSERT INTO liquor_store VALUES (4, 'Rum', 28, 12.99, 'Captain Morgan');
INSERT INTO liquor_store VALUES (5, 'Rum', 64, 16.99, 'Bacardi');
INSERT INTO liquor_store VALUES (6, 'Rum', 87, 17.99,'Sailor Jerry');
INSERT INTO liquor_store VALUES (7, 'Whisky', 32, 32.99, 'Glenmorgan');
INSERT INTO liquor_store VALUES (8, 'Whisky', 42, 40.99, 'Jamesons');
INSERT INTO liquor_store VALUES (9, 'Whisky', 36, 49.99, 'Notorious');
INSERT INTO liquor_store VALUES (10, 'Gin', 42, 16.99, 'Bombay Sapphire');
INSERT INTO liquor_store VALUES (11, 'Gin', 56, 18.99, 'Tangery De Sevile');
INSERT INTO liquor_store VALUES (12, 'Beer', 293, 9.99, 'Budweiser');
INSERT INTO liquor_store VALUES (13, 'Beer', 32, 12.99, 'Stella Artois');
INSERT INTO liquor_store VALUES (14, 'Beer', 54, 16.99, 'San Miguel');
INSERT INTO liquor_store VALUES (15, 'Beer', 32, 12.99, 'Guinness');

SELECT brand, price FROM liquor_store ORDER BY price;

SELECT name, SUM(quantity) from liquor_store group by name;

2. Pick one of those data sets or create a data set like that, and use advanced SELECT queries to discover things about the data. 
What sort of questions might one have about that data, like if they were using it for an app or a business idea? Here are some ideas:

What are average, max, and min values in the data?
What about those numbers per category in the data (using HAVING)?
What ways are there to group the data values that don’t exist yet (using CASE)?
What interesting ways are there to filter the data (using AND/OR)?

SELECT AVG(fertility_rate) from countries;
SELECT MAX(area_sq_km), name from countries ORDER by name;
SELECT MIN(net_migrants), name from countries ORDER by name;

SELECT name, SUM(percent_of_world_pop) AS percent FROM countries
GROUP BY name
HAVING percent > 2;

SELECT count(*),
CASE WHEN percent_of_world_pop > 15 then "Huge"
WHEN percent_of_world_pop > 2 then "Large"
WHEN percent_of_world_pop > 1 then "Medium" 
ELSE "small"
END as "percent"
GROUP by "percent"
FROM countries;

SELECT name from countries WHERE median_age < 18 AND fertility_rate > 2;

SELECT name from countries WHERE population > 100000000 OR net_migrants < 100000 ORDER BY fertility_rate;

3. In this project, you’re going to make your own table with some small set of “famous people”, then make more tables about things they do and join those to create nice human readable lists.

For example, here are types of famous people and the questions your data could answer:

Movie stars: What movies are they in? Are they married to each other?
Singers: What songs did they write? Where are they from?
Authors: What books did they write?
Fictional characters: How are they related to other characters? What books do they show up in?

CREATE TABLE movie_stars (id INTEGER PRIMARY KEY AUTOINCREMENT, fullname text, age INTEGER, partner TEXT, oscarwins INTEGER, moviecredits TEXT);

INSERT INTO movie_stars values (1, "Brad Pitt", 56, "Angelina Jolie", 2, "Once upon a time...");
INSERT INTO movie_stars values (2, "Leo Di Caprio", 45, "Margot Robbie", 1, "Once upon a time...");
INSERT INTO movie_stars values (3, "Angelina Jolie", 45, "Brad Pitt", 2, "Maleficient");
INSERT INTO movie_stars values (4, "Margot Robbie", 30, "Leo Di Caprio", 0, "Once upon a time..."); 
INSERT INTO movie_stars values (5, "Al Pacino", 80, "Jan Tarrant", 1, "Scarface"); 
INSERT INTO movie_stars values (6, "Tom Hanks", 64, "Rita Wilson", 4, "Forrest Gump");
INSERT INTO movie_stars values (7, "Robert De Niro", 75, "Big Booty Becky", 5, "Shark Tale");
INSERT INTO movie_stars values (8, "Marlon Brando", 88, "Nicky Minaj", 3, "Grimting");
INSERT INTO movie_stars values (9, "Denzel Washington", 55, "Cardi B", 1, "Training Day");
INSERT INTO movie_stars values (10, "Morgan Freeman", 77, "Lucy Freeman", 4, "Shawshank Redemption"); 
INSERT INTO movie_stars values (11, "Christian Bale", 34, "Harley Quinn", 1, "Batman Begins");
INSERT INTO movie_stars values (12, "John Cena", 54, "Rita Ora", 2, "You can't see me"); 
INSERT INTO movie_stars values (13, "Gary Oldman", 43, "Suzy Younglady", 4, "Beetlejuice");
INSERT INTO movie_stars values (14, "Harrison Ford", 66, "Shia Labeouf", 2, "Indiana Jones");
INSERT INTO movie_stars values (15, "Clint Eastwood", 54, "Look Westwood", 1, "The Good, The Bad, The Ugly");

CREATE TABLE hobbies (id INTEGER PRIMARY KEY AUTOINCREMENT, fullname text, hobby TEXT);

INSERT INTO hobbies values (1, "Brad Pitt", "Driveby Shooting");
INSERT INTO hobbies values (2, "Leo Di Caprio", "Being Cool Guy");
INSERT INTO hobbies values (3, "Margot Robbie", "Blazing It");
INSERT INTO hobbies values (4, "Leo Di Caprio", "Genocide");
INSERT INTO hobbies values (5, "Angelina Jolie", "Dancing");
INSERT INTO hobbies values (6, "Al Pacino", "Cocaine");


Select movie_stars.fullname, hobbies.hobby from movie_stars JOIN hobbies
ON movie_stars.id = hobbies.id
WHERE movie_stars.id =  "2";

SELECT a.fullname, b.partner from movie_stars
JOIN movie_stars a
ON movie_stars.id = a.id
JOIN movie_stars b
ON movie_stars.id = b.id;

SELECT fullname, oscarwins from movie_stars WHERE age >"40" AND oscarwins > 1;

SELECT fullname from hobbies

4. Think about your favorite apps, and pick one that stores your data- like a game that stores scores, an app that lets you post updates, etc. Now in this project, you're going to imagine that the app stores your data in a SQL database (which is pretty likely!), and write SQL statements that might look like their own SQL.

CREATE a table to store the data.
INSERT a few example rows in the table.
Use an UPDATE to emulate what happens when you edit data in the app.
Use a DELETE to emulate what happens when you delete data in the app.

CREATE TABLE Runescape (Id INTEGER PRIMARY KEY, name TEXT, cmblevel INTEGER, wclvl INTEGER, chat TEXT);

INSERT INTO Runescape (name, cmblevel, wclvl, chat) VALUES ("Sole Bamba", 104, 99, "Hello world");
INSERT INTO Runescape (name, cmblevel, wclvl, chat) VALUES ("Douglas Deep", 3, 92, "Ban Jaseel");
INSERT INTO Runescape (name, cmblevel, wclvl, chat) VALUES ("Jungle Jarv", 120, 76, "Douglas is a loser");
INSERT INTO Runescape (name, cmblevel, wclvl, chat) VALUES ("Jaseel", 126, 99, "Dont say rude words");
INSERT INTO Runescape (name, cmblevel, wclvl, chat) VALUES ("2chan", 99, 32, "You're poor");
INSERT INTO Runescape (name, cmblevel, wclvl, chat) VALUES ("Laythan1998", 76, 32, "I'm rich");
INSERT INTO Runescape (name, cmblevel, wclvl, chat) VALUES ("Sonia Strumm", 43, 66, "I love Dougie");
INSERT INTO Runescape (name, cmblevel, wclvl, chat) VALUES ("Aspii", 118, 99, "I dont know");

SELECT * from Runescape;

UPDATE Runescape SET name = "Douglas Rich" WHERE name = "Douglas Deep";

SELECT * from Runescape;

DELETE from Runescape where cmblevel < 100; 

SELECT * from Runescape;
