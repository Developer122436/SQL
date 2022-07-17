  /*  נתוני שיחות נכנסות של חודש קודם באופן אוטומטי */
  
  DECLARE @MokedID AS Integer
  DECLARE @ProjectID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  
  SET @ProjectID=3100
  SET @MokedID=3105
  SET @sDateCalls=CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0), 111)
  SET @eDateCalls=CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1), 111)
  
  SELECT 
       row_date,
       ID_CardNum AS 'תעודת זהות'
       ,logid AS 'יוזר לוגין'
       ,FullNameHeb AS 'שם מלא'
       ,CrewName AS 'ראש צוות'
       ,ISNULL(SUM(acdcalls), 0) + ISNULL(SUM(abncalls), 0) AS 'כמות שיחות נכנסות'
  FROM 
       (SELECT row_date, acdcalls, abncalls, split, logid, acdtime, i_stafftime
        FROM RepGateDB.CmsClalit.hagent 
        WHERE row_date between @sDateCalls and @eDateCalls AND split IN(210,208,211,213,212,154)) AS HA
  INNER JOIN (
        SELECT *
        FROM RepGateWorkers.dbo.fn_ProjectAgentsList2(@ProjectID,@sDateCalls,@eDateCalls)
	    WHERE MokedID IN (@MokedID)
  ) AS AL ON AL.LoginID = HA.logid  AND HA.row_date = AL.DateX
  GROUP BY row_date, logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;