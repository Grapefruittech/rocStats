USE roc;

/* total number of rows*/

SELECT COUNT(*) AS Count
FROM gear g
INNER JOIN rentals r
ON g.inventory_code = r.inventory_code
ORDER BY r.rental_id;

/***********************
	TYPES OF GEAR
***********************/
/* Number of rentals per activity */

SELECT SUBSTRING(g.inventory_code, 1, 2) AS Activity
	   , COUNT(*) AS Count
FROM gear g
INNER JOIN rentals r
ON g.inventory_code = r.inventory_code
GROUP BY Activity
ORDER BY COUNT(*) DESC;

/* Number of rentals per item */

SELECT SUBSTRING(g.inventory_code, 1, 2) AS Activity
	   , SUBSTRING(g.inventory_code, 4, 2) AS ItemType
	   , g.name
	   , COUNT(*) AS Count
FROM gear g
INNER JOIN rentals r
ON g.inventory_code = r.inventory_code
GROUP BY Activity, ItemType
ORDER BY COUNT(*) DESC
INTO OUTFILE '/tmp/rentalsPerItem.tab';

SELECT SUBSTRING(g.inventory_code, 1, 2) AS Activity
	   , SUBSTRING(g.inventory_code, 4, 2) AS ItemType
	   , SUBSTRING(g.inventory_code, 7, 2) AS ItemNumber
	   , g.name
	   , COUNT(*) AS Count
FROM rentals r
INNER JOIN gear g
ON g.inventory_code = r.inventory_code
WHERE SUBSTRING(g.inventory_code, 4, 2) IN ('SB', 'TN', 'BP')
GROUP BY g.inventory_code
ORDER BY g.inventory_code
INTO OUTFILE '/tmp/itemSpecific.tab';


/***********************
	LENGTH OF RENTAL
***********************/

DROP TEMPORARY TABLE IF EXISTS lengthOfRental;

CREATE TEMPORARY TABLE lengthOfRental AS
(SELECT g.inventory_code AS invCode, g.name AS name, r.returned AS returned,
	   CASE r.returned
	   WHEN 0
	   		THEN TIMESTAMPDIFF(DAY,	r.out_datetime, '2014-09-18')
	   ELSE TIMESTAMPDIFF(DAY, r.out_datetime, r.return_datetime)
	   END AS daysOut
FROM gear g
INNER JOIN rentals r
ON g.inventory_code = r.inventory_code);


/* Average time out by itemtype */
SELECT SUBSTRING(l.invCode, 1, 2) AS Activity
	   , SUBSTRING(l.invCode, 4, 2) AS ItemType
	   , l.name
	   , AVG(l.daysOut) AS AverageDaysOut
FROM lengthOfRental l
GROUP BY ItemType
ORDER BY AverageDaysOut DESC
INTO OUTFILE '/tmp/timeOutPerItem.tab';



/***********************
	Specific Items
***********************/

/* Sleeping bags */
SELECT r.inventory_code
	   , g.name
	   , g.description
	   , COUNT(*) AS Count
FROM rentals r
INNER JOIN gear g
ON g.inventory_code = r.inventory_code
WHERE SUBSTRING(r.inventory_code, 4, 2) = 'SB'
GROUP BY r.inventory_code
ORDER BY Count DESC
LIMIT 10;


/* Tents */
SELECT r.inventory_code
	   , g.name
	   , g.description
	   , COUNT(*) AS Count
FROM rentals r
INNER JOIN gear g
ON g.inventory_code = r.inventory_code
WHERE SUBSTRING(r.inventory_code, 4, 2) = 'TN'
GROUP BY r.inventory_code
ORDER BY Count DESC
LIMIT 10;


/* Backpack */
SELECT r.inventory_code
	   , g.name
	   , g.description
	   , COUNT(*) AS Count
FROM rentals r
INNER JOIN gear g
ON g.inventory_code = r.inventory_code
WHERE SUBSTRING(r.inventory_code, 4, 2) = 'BP'
GROUP BY r.inventory_code
ORDER BY Count DESC
LIMIT 10;
