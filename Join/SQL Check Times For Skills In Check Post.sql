DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

SET @t1 = GETDATE();
  /**** שאילתא להוצאת נתוני זימון של מוקד צ'ק פוסט כללית ****/
  DECLARE @MokedID AS Integer
  DECLARE @ProjectID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)
  
  SET @ProjectID=3100
  SET @MokedID=5759
  SET @sDateCalls='2022-02-01'
  SET @eDateCalls='2022-02-14'
  SET @sDateAgent=CONVERT(VARCHAR(10), GETDATE(), 111)
  SET @eEndAgent=CONVERT(VARCHAR(10), GETDATE(), 111)

  SELECT 
       ID_CardNum
       ,logid
       ,FullNameHeb
       ,CrewName
      ,SUM(acdcalls) AS acdcalls
      ,RIGHT('00' + CAST(DATEPART(hh, SUM(CAST(acdtime AS Float)/3600/24) / SUM(acdcalls)) as varchar(6)), 2) + ':'+
       RIGHT('00' + CAST(DATEPART(mi, SUM(CAST(acdtime AS Float)/3600/24) / SUM(acdcalls)) as varchar(6)), 2) + ':'+
       RIGHT('00' + CAST(DATEPART(ss, SUM(CAST(acdtime AS Float)/3600/24) / SUM(acdcalls)) as varchar(6)), 2) AS acdTimeAverage
      ,SUM(ROUND(CAST(i_stafftime AS Float)/3600,2)) AS loginX
      ,ROUND(SUM(acdcalls) / SUM(ROUND(CAST(i_stafftime AS Float)/3600,2)),2) AS numberOfCallsInHour
      ,CAST(CAST(SUM(CAST(acdtime AS Float)/3600) / SUM(ROUND(CAST(i_stafftime AS Float)/3600,2))*100 as decimal(18,2)) as varchar(6)) + ' %' as percentTaasukaX
  FROM 
       (SELECT row_date, acdcalls, split, logid, acdtime, i_stafftime
	    FROM RepGateDB.CmsClalit.hagent 
        WHERE row_date between @sDateCalls and @eDateCalls AND acdcalls IS NOT NULL AND split IN(110,111,112,113,114,270,271,272,120,169,161,130,140,263,262,166,264)) AS HA
  INNER JOIN RepGateWorkers.dbo.fn_ProjectAgentsList2(@ProjectID,@sDateAgent,@eEndAgent) AS AL ON AL.LoginID = HA.logid AND MokedID IN (@MokedID)  
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 											 											  
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;

SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;