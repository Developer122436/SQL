  /*  נתוני שיחות נכנסות של חודש קודם באופן אוטומטי עד ה20 כל חודש*/
  
  DECLARE @MokedID AS Integer
  DECLARE @ProjectID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  
  SET @ProjectID=3100
  SET @MokedID=3105
  SET @sDateCalls=CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE() - 20), 0), 111)
  SET @eDateCalls=CONVERT(VARCHAR(10), DATEADD(MONTH, ((YEAR(GETDATE() - 20) - 1900) * 12) + MONTH(GETDATE() - 20), -1), 111)
  
  SELECT 
       ID_CardNum AS 'תעודת זהות'
       ,logid AS 'יוזר לוגין'
       ,FullNameHeb AS 'שם מלא'
       ,CrewName AS 'ראש צוות'
       ,ISNULL(SUM(acdcalls), 0) + ISNULL(SUM(abncalls), 0) AS 'כמות שיחות נכנסות'
  FROM 
       (SELECT row_date, acdcalls, abncalls, split, logid, acdtime, i_stafftime
        FROM RepGateDB.CmsClalit.hagent 
        WHERE row_date between @sDateCalls and @eDateCalls AND split IN(429,430,431,432,433)) AS HA
  INNER JOIN (
        SELECT *
        FROM RepGateWorkers.dbo.fn_ProjectAgentsList2(@ProjectID,@sDateCalls,@eDateCalls)
	    WHERE MokedID IN (@MokedID)
  ) AS AL ON AL.LoginID = HA.logid  AND HA.row_date = AL.DateX
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;
  