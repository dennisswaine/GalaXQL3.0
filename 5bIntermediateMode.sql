COUNT PRACTICE QUESTION 1: Write a query to count the number of non-null rows in the low column.

SELECT COUNT(low)
  FROM tutorial.aapl_historical_stock_price
  
COUNT PRACTICE QUESTION 2: Write a query that determines counts of every single column. Which column has the most null values?

SELECT COUNT(date) AS date, COUNT(year) AS year, COUNT(month) AS month, 
COUNT(open) AS open, COUNT(high) AS high,COUNT(low) AS low, COUNT(close) AS close, COUNT(volume) AS volume
  FROM tutorial.aapl_historical_stock_price
  
SUM PRACTICE QUESTION 1: Write a query to calculate the average opening price (hint: you will need to use both COUNT and SUM, as well as some simple arithmetic.).

SELECT SUM(open)/ COUNT(open) as avg_open_price
  FROM tutorial.aapl_historical_stock_price
  
MIN/MAX PRACTICE QUESTION 1: What was Apples lowest stock price (at the time of this data collection)?

SELECT MIN(low)
FROM tutorial.aapl_historical_stock_price

MIN/MAX PRACTICE QUESTION 2: What was the highest single-day increase in Apples share value?

SELECT MAX(close-open)
FROM tutorial.aapl_historical_stock_price

AVG PRACTICE QUESTION 1: Write a query that calculates the average daily trade volume for Apple stock.

SELECT AVG(volume)
FROM tutorial.aapl_historical_stock_price

GROUP BY PRACTICE QUESTION 1: Calculate the total number of shares traded each month. Order your results chronologically.

SELECT month, year, SUM(volume)
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY year, month

GROUP BY PRACTICE QUESTION 2: Write a query to calculate the average daily price change in Apple stock, grouped by year.

SELECT year, AVG(open-close)
FROM tutorial.aapl_historical_stock_price
GROUP BY 1 
ORDER BY 1

GROUP BY PRACTICE QUESTION 3: Write a query that calculates the lowest and highest prices that Apple stock achieved each month.

SELECT year, month, MAX(high), MIN(low) 
FROM tutorial.aapl_historical_stock_price
GROUP BY 1, 2
ORDER BY 1, 2

Query clause order
As mentioned in prior lessons, the order in which you write the clauses is important. Heres the order for everything youve learned so far:

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY

C*SE PRACTIE QUESTION 1: Write a query that includes a column that is flagged "yes" when a player is from California, and sort the results with those players first.

SELECT player_name, CASE WHEN state = 'CA' THEN 'Yes' ELSE NULL END AS from_cali
FROM benn.college_football_players
ORDER BY 2

C*SE PRACTICE QUESTION 2: Write a query that includes players' names and a column that classifies them into four categories based on height. Keep in mind that the answer we provide is only one of many possible answers, since you could divide players' heights in many ways.

SELECT player_name, height, 
CASE WHEN height > 79 then 'big boy'
WHEN height > 74 AND height <= 79 then 'tall boy'
WHEN height > 72 AND height <= 74 then 'medium boy'
ELSE 'small boy' END AS height_category
FROM benn.college_football_players

C*SE PRACTICE QUESTION 3: Write a query that selects all columns from benn.college_football_players and adds an additional column that displays the players name if that player is a junior or senior.

SELECT *, 
CASE WHEN year IN ('JR', 'SR') THEN player_name
ELSE NULL END AS upperclassmen
FROM benn.college_football_players

C*SE PRACTICE QUESTION 4: Write a query that counts the number of 300lb+ players for each of the following regions: West Coast (CA, OR, WA), Texas, and Other (Everywhere else).

SELECT CASE WHEN state IN ('CA', 'WA', 'OR') THEN 'West_Coast'
WHEN state IN ('TX') THEN 'Texas'
ELSE 'Other' END AS region ,
Count(*) AS count
FROM benn.college_football_players
WHERE weight >= 300
GROUP BY region

C*SE PRACTIC QUESTION 5: Write a query that calculates the combined weight of all underclass players (FR/SO) in California as well as the combined weight of all upperclass players (JR/SR) in California.

SELECT CASE WHEN year IN ('FR', 'SO') THEN 'underclass'
WHEN year IN ('JR', 'SR') THEN 'upperclass'
ELSE NULL END AS class_divide,
SUM(weight) AS combined_weights
FROM benn.college_football_players
WHERE state = 'CA'
GROUP BY 1

C*SE PRACTIC QUESTION 6: Write a query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total number of players. Order results such that states with the most players come first.

SELECT state,
COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
COUNT(1) AS total_players
FROM benn.college_football_players
GROUP BY state 
ORDER BY total_players DESC

C*SE PRACTICE QUESTION 7: Write a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.

SELECT CASE WHEN school_name < 'n' THEN 'A-M'
WHEN chool_name >= 'n' THEN 'N-Z'
ELSE NULL END AS school_name_group,
COUNT(1) AS players
FROM benn.college_football_players
GROUP BY 1

DISTINCT PRACTICE QUESTIONS 1: Write a query that returns the unique values in the year column, in chronological order.

SELECT DISTINCT year
FROM tutorial.aapl_historical_stock_price
ORDER BY year

DISTINCT PRACTICE QUESTION 2: Write a query that counts the number of unique values in the month column for each year.

SELECT year,
       COUNT(DISTINCT month) AS months_count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year
 ORDER BY yea

DISTINCT PRACTICE QUESTION 3: Write a query that separately counts the number of unique values in the month column and the number of unique values in the `year` column.
 
SELECT COUNT(DISTINCT year) AS number_of_years,
COUNT(DISTINCT month) AS number_of_months
FROM tutorial.aapl_historical_stock_price

JOINS PRACTICE QUESTION 1: Write a query that selects the school name, player name, position, and weight for every player in Georgia, ordered by weight (heaviest to lightest). Be sure to make an alias for the table, and to reference all column names in relation to the alias.

SELECT players.school_name, players.player_name, players.position, players.weight 
FROM benn.college_football_players players
WHERE state = 'GA'
ORDER BY players.weight DESC

INNER JOIN PRACTICE QUESTION 1: Write a query that displays player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division.

SELECT players.player_name,
       teams.school_name, 
       teams.conference
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name
WHERE teams.division = 'FBS (Division I-A Teams)'

LEFT JOIN PRACTICE QUESTION 1: Write a query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null rows in each table.

SELECT count(companies.permalink) AS companies_rowcount,
count(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
	
LEFT JOIN PRACTICE QUESTION 2: Modify the query above to be a LEFT JOIN. Note the difference in results.

SELECT count(companies.permalink) AS companies_rowcount,
count(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
	
LEFT JOIN PRACTICE QUESTION 3: Count the number of unique companies dont double-count companies) and unique acquired companies by state. Do not include results for which there is no state data, and order by the number of acquired companies from highest to lowest.

SELECT companies.state_code,
count(DISTINCT companies.permalink) AS unique_companies,
count(DISTINCT acquisitions.company_permalink) AS unique_acquisitions
  FROM tutorial.crunchbase_companies companies
  JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
    WHERE companies.state_code IS NOT NULL
    GROUP BY 1
    ORDER BY 3 DESC
	
RIGHT JOIN PRACTICE QUESTION 1: Rewrite the previous practice query in which you counted total and acquired companies by state, but with a RIGHT JOIN instead of a LEFT JOIN. The goal is to produce the exact same results.

SELECT companies.state_code,
COUNT(DISTINCT companies.permalink) AS unique_comapnies,
COUNT (DISTINCT acquisitions.company_permalink) AS unique_acquisitions
FROM tutorial.crunchbase_acquisitions acquisitions
RIGHT JOIN tutorial.crunchbase_companies companies
ON acquisitions.company_permalink = companies.permalink 
WHERE companies.state_code IS NOT NULL 
GROUP BY 1
ORDER BY 3 DESC

JOINS USING WHERE OR ON PRACTICE QUESTION 1:Write a query that shows a companys name, "status" (found in the Companies table), and the number of unique investors in that company. Order by the number of investors from most to fewest. Limit to only companies in the state of New York.

SELECT companies.name AS company_name,
companies.status,
COUNT(DISTINCT investments.investor_name) AS unique_investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
    WHERE companies.state_code = 'NY'
GROUP BY 1,2
ORDER BY 3 DESC


JOINS USING WHERE OR ON PRACTICE QUESTION 2: Write a query that lists investors based on the number of companies in which they are invested. Include a row for companies with no investor, and order from most companies to least.

SELECT CASE WHEN investments.investor_name IS NULL then 'No Investor'
ELSE investments.investor_name END AS investor,
COUNT (DISTINCT companies.permalink) AS companies_invested_in
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_investments investments 
ON companies.permalink = investments.company_permalink
GROUP BY 1
ORDER BY 2 DESC


FULL OUTER JOIN PRACTICE QUESTION 1:  Write a query that joins tutorial.crunchbase_companies and tutorial.crunchbase_investments_part1 using a FULL JOIN. Count up the number of rows that are matched/unmatched as in the example above.

SELECT COUNT(C*SE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NULL
                  THEN companies.permalink ELSE NULL END) AS companies_only,
       COUNT(C*SE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NOT NULL
                  THEN companies.permalink ELSE NULL END) AS both_tables,
       COUNT(C*SE WHEN companies.permalink IS NULL AND investments.company_permalink IS NOT NULL
                  THEN investments.company_permalink ELSE NULL END) AS investments_only
FROM tutorial.crunchbase_companies companies
FULL JOIN tutorial.crunchbase_investments_part1 investments
ON companies.permalink = investments.company_permalink 

UNION PRACTICE QUESTION 1: Write a query that appends the two crunchbase_investments datasets above (including duplicate values). Filter the first dataset to only companies with names that start with the letter "T", and filter the second to companies with names starting with "M" (both not case-sensitive). Only include the company_permalink, company_name, and investor_name columns.

SELECT company_permalink, company_name, investor_name
  FROM tutorial.crunchbase_investments_part1
WHERE company_name ILIKE 'T%'

 UNION ALL

SELECT company_permalink, company_name, investor_name
  FROM tutorial.crunchbase_investments_part1
WHERE company_name ILIKE 'M%'

UNION PRACTICE QUESTION 2: Write a query that shows 3 columns. The first indicates which dataset (part 1 or 2) the data comes from, the second shows company status, and the third is a count of the number of investors.

SELECT 'investments_part1' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2

 UNION ALL
 
 SELECT 'investments_part2' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part2 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2
 
 