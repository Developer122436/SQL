WITH cte as
(
	select getdate() as n
	union all
	select dateadd(DAY,-1,n) from cte where dateadd(dd,-1,n)> DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)
)
SELECT CAST(n AS DATE) AS 'תאריך'
, ISNULL(SUM(ROUND(CAST(DATEDIFF(SECOND, TAL.login, TAL.logout) AS Float)/3600,2)),0) AS 'שעות הדרכה'
FROM (
	  SELECT * 
      FROM cte
      WHERE CAST(n AS DATE) BETWEEN DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0) AND DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)) AllDates
LEFT JOIN ( SELECT *
			FROM [dbo].[TrainingAgentsLogin]
			WHERE ProjectX IN ('ש.ל.ה') ) TAL ON CAST(TAL.DateX AS DATE) = CAST(AllDates.n AS DATE)
GROUP BY CAST(AllDates.n AS DATE)
ORDER BY CAST(AllDates.n AS DATE) 


WITH cte as
(
	select getdate() as n
	union all
	select dateadd(DAY,-1,n) from cte where dateadd(dd,-1,n)> DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)
)
SELECT CAST(n AS DATE) AS 'תאריך'
, ISNULL(SUM(ROUND(CAST(DATEDIFF(SECOND, TAL.login, TAL.logout) AS Float)/3600,2)),0) AS 'שעות הדרכה'
FROM (
	  SELECT * 
      FROM cte
      WHERE CAST(n AS DATE) BETWEEN DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0) AND DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)) AllDates
LEFT JOIN ( SELECT *
			FROM [dbo].[TrainingAgentsLogin]
			WHERE ProjectX IN ('ש.ל.ה באר שבע') ) TAL ON CAST(TAL.DateX AS DATE) = CAST(AllDates.n AS DATE)
GROUP BY CAST(AllDates.n AS DATE)
ORDER BY CAST(AllDates.n AS DATE) 

  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)

  SET @sDateAgent='2022-03-01'
  SET @eEndAgent='2022-03-31'

SELECT DateX, SUM(ROUND(CAST(DATEDIFF(second, LogIn, LogOut) AS Float)/3600,2))  AS 'שעות הדרכה'
FROM [RepGateDB].[dbo].[TrainingAgentsLogin]
WHERE ProjectX IN ('ש.ל.ה') AND DateX BETWEEN @sDateAgent AND @eEndAgent
GROUP BY DateX, ProjectX
ORDER BY DateX DESC



  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)

  SET @sDateAgent='2022-03-01'
  SET @eEndAgent='2022-03-31'

SELECT DateX, SUM(ROUND(CAST(DATEDIFF(second, LogIn, LogOut) AS Float)/3600,2))  AS 'שעות הדרכה'
FROM [RepGateDB].[dbo].[TrainingAgentsLogin]
WHERE ProjectX IN ('ש.ל.ה באר שבע') AND DateX BETWEEN @sDateAgent AND @eEndAgent
GROUP BY DateX, ProjectX
ORDER BY DateX DESC
