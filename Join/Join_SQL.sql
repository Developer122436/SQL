  /*** שאילתא להרצת כמות שיחות נענות, ננטשות ונכנסות לפי סקילים ***/
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  
  SET @sDateCalls='2020-01-01'
  SET @eDateCalls=CONVERT(VARCHAR(10), GETDATE(), 111)

  SELECT 
       CONVERT(VARCHAR(7), row_date, 126) AS 'תאריך'
          ,CASE WHEN split=270 THEN 'בדיקות קורונה ערבית ' WHEN split=271 THEN 'בדיקות קורונה רוסית ' ELSE 'בדיקות קורונה אנגלית' END AS 'שם סקיל'
	,ISNULL(SUM(acdcalls),0) AS 'נענות'
	,ISNULL(SUM(abncalls),0) AS 'ננטשות'
	,ISNULL(SUM(acdcalls),0) + ISNULL(SUM(abncalls),0) AS 'כמות נכנסות'
   FROM [RepGateDB].[CmsClalit].[hsplit]
  WHERE SPLIT IN(270,271,272) AND row_date between @sDateCalls AND @eDateCalls 
  GROUP BY CONVERT(VARCHAR(7), row_date, 126), split
  ORDER BY CONVERT(VARCHAR(7), row_date, 126)