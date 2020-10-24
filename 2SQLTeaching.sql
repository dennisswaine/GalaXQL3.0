Lesson 1: SELECT *. Let's start by grabbing all of the data in one table. We have a table called family_members that is shown below. In order to grab all of that data, please run the following command: SELECT * FROM family_members;

SELECT * from family_members;

Lesson 2: SELECT specific columns. Can you return just the name and species columns?

SELECT name, species FROM family_members;

Lesson 3: WHERE ... Equals. Can you run a query that returns all of the rows that refer to dogs?

SELECT * from family_members WHERE species = 'dog';

Lesson 4: WHERE ... Greater than. Can you run return all rows of family members whose num_books_read is greater than 190?

SELECT * from family_members WHERE num_books_read > 190;

Lesson 5: WHERE ... Greater than or equal. Can you return all rows in family_members where num_books_read is a value greater or equal to 180?

SELECT * from family_members WHERE num_books_read  >= 180;

Lesson 6: AND. Can you find all of Pickles' friends that are dogs and under the height of 45cm?

SELECT * from friends_of_pickles WHERE height_cm < 45 AND species = 'dog';

Lesson 7: OR. Can you find all of Pickles' friends that are dogs or under the height of 45cm?

SELECT * from friends_of_pickles WHERE species = 'dog' OR height_cm < 45;

Lesson 8: IN. Can you run a query that would return the rows that are not cats or dogs?

SELECT * FROM friends_of_pickles WHERE species NOT IN ('cat', 'dog');

Lesson 9: DISTINCT. Can you return a list of the distinct species of animals greater than 50cm in height?

SELECT DISTINCT species FROM friends_of_pickles WHERE height_cm  > 50;

Lesson 10: ORDER BY. Can you run a query that sorts the friends_of_pickles by height_cm in descending order?

SELECT * FROM friends_of_pickles ORDER BY height_cm DESC;

Lesson 11: LIMIT # of returned rows. Can you return the single row (and all columns) of the tallest friends_of_pickles?

SELECT * FROM friends_of_pickles ORDER BY height_cm DESC LIMIT 1;

Lesson 12: COUNT(*). SELECT COUNT(*) FROM friends_of_pickles; returns the total number of rows in the table friends_of_pickles. Try this for yourself.

SELECT COUNT(*) FROM friends_of_pickles;

Lesson 13: COUNT(*) ... WHERE. Can you return the number of rows in friends_of_pickles where the species is a dog?

SELECT COUNT(*) FROM friends_of_pickles WHERE species = 'dog';

Lesson 14: SUM. Can you find the total num_books_read made by this family?

SELECT SUM(num_books_read) FROM family_members;

Lesson 15: AVG. Can you find the average num_books_read made by each family member?

SELECT AVG(num_books_read) FROM family_members;

Lesson 16: MAX and MIN. Can you find the highest num_books_read that a family member makes?

SELECT MAX(num_books_read) FROM family_members;

Lesson 17: GROUP BY. Can you return the tallest height for each species? Remember to return the species name next to the height too, like in the example query.

SELECT MAX(height_cm), species FROM friends_of_pickles GROUP BY species;

Lesson 18: Nested queries. Can you return the family members that have the highest num_books_read?

SELECT * FROM family_members WHERE num_books_read = (SELECT MAX(num_books_read) FROM family_members);

Lesson 19: NULL. Can you return all of the rows of family_members where favorite_book is not null?

SELECT * FROM family_members WHERE favorite_book IS NOT NULL;

Lesson 20: Date. Can you return a list of celebrities that were born after September 1st, 1980?

SELECT * from celebs_born WHERE birthdate > '1980-09-01';

Lesson 21: Inner joins. Can you use an inner join to pair each character name with the actor who plays them? Select the columns: character.name, character_actor.actor_name

SELECT character.name, character_actor.actor_name
FROM character
INNER JOIN character_actor
ON character.id = character_actor.character_id;

Lesson 22: Multiple joins. Can you use two joins to pair each character name with the actor who plays them? Select the columns: character.name, actor.name

SELECT character.name, actor.name FROM character
INNER JOIN actor
ON character.id = character_actor.character_id
INNER JOIN character_actor
ON character_actor.actor_id = actor.id;

Lesson 23: Joins with WHERE. Can you return a list of characters and TV shows that are not named "Willow Rosenberg" and not in the show "How I Met Your Mother"?

SELECT character.name, tv_show.name
FROM character
INNER JOIN character_tv_show
ON character.id = character_tv_show.character_id
INNER JOIN tv_show
ON tv_show.id = character_tv_show.tv_show_id 
WHERE character.name != 'Willow Rosenberg' AND tv_show.name != 'How I Met Your Mother';

Lesson 24: Left joins. Can you use left joins to match character names with the actors that play them? Select the columns: character.name, actor.name

SELECT character.name, actor.name
FROM character 
LEFT JOIN character_actor
ON character.id = character_actor.character_id
LEFT JOIN actor
ON actor.id = character_actor.actor_id;

Lesson 25: Table alias. Can you use left joins to match character names with the actors that play them, and use aliases to make the query shorter? The aliases for character, character_actor, and actor should be c, ca, and a.

SELECT c.name, a.name FROM character as c
LEFT JOIN character_actor as ca
ON c.id = ca.character_id
LEFT JOIN actor as a
ON a.id = ca.actor_id;

Lesson 26: Column alias. Can you use left joins to match character names with the actors that play them, and use aliases to call the two columns returned character and actor?

SELECT character.name AS character, actor.name AS actor
FROM character
LEFT JOIN character_actor
ON character.id = character_actor.character_id
LEFT JOIN actor
ON actor.id = character_actor.actor_id;

Lesson 27: Self joins. Can you run a query that returns the name of an employee and the name of their boss? Use column aliases to make the columns employee_name and boss_name.

SELECT e1.name AS employee_name, e2.name AS boss_name
FROM employees AS e1
INNER JOIN employees AS e2
ON e1.boss_id = e2.id

Lesson 28: LIKE. Can you run a query that returns "Robot" followed by a year between 2000 and 2099? (So 2015 is a valid value at the end, but 2123 is not.)

SELECT * from robots WHERE name LIKE '%Robot 20%';

Lesson 29: CASE. Can you return the results with a column named sound that returns "talk" for humans, "bark" for dogs, and "meow" for cats?

SELECT *, CASE WHEN species = 'human' THEN 'talk' WHEN species = 'dog' THEN 'bark' ELSE 'meow' END AS sound
FROM friends_of_pickles;

Lesson 30: SUBSTR.  Can you return all of the robots that are located in NY?

SELECT * FROM robots WHERE SUBSTR(location, -2) LIKE 'NY';

Lesson 31: COALESCE. Suppose that a fighter's tank could count as a weapon, and it would take precedence over the gun and the sword. Could you find each fighter's weapon in that scenario?

SELECT name, COALESCE(tank,gun,sword) AS weapon FROM fighters;
