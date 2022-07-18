    --- חיפוש נציגי צק פוסט לפי סקילים זימון ---
  DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @tDate AS DATE
  
  SET @tDate=GETDATE()
  SET @MokedID=5759
  SET @sDateCalls='2021-11-14'
  SET @eDateCalls='2021-11-14'
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
		FROM [RepGateDB].[CmsClalit].[hagent]
		WHERE (row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL) OR (logid = 202713 AND row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL) ) AS HA
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@sDateAgent,@eEndAgent) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE (MokedID IN (@MokedID) AND SkillSubGroup LIKE ('%זימון%')) 
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;

  --- חיפוש נציגי צק פוסט לפי סקילים מידע ---
  DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @tDate AS DATE
  
  SET @tDate=CONVERT(VARCHAR(10), GETDATE(), 111)
  SET @MokedID=5759
  SET @sDateCalls='2021-10-10'
  SET @eDateCalls='2021-10-19'
  
  SELECT 
       ID_CardNum
       ,logid
       ,FullNameHeb
       ,CrewName
      ,SUM(acdcalls) AS acdcalls
      ,SUM(CAST(acdtime AS Float)/3600/24) / SUM(acdcalls) AS acdtimeaverage
      ,SUM(ROUND(CAST(i_stafftime AS Float)/3600,2)) AS loginX
      ,ROUND(SUM(acdcalls) / SUM(ROUND(CAST(i_stafftime AS Float)/3600,2)),2) AS numberofcalls
      ,CAST(CAST(SUM(CAST(acdtime AS Float)/3600) / SUM(ROUND(CAST(i_stafftime AS Float)/3600,2))*100 as decimal(18,2)) as varchar(6)) + ' %' as TaasukaX
  FROM (
        SELECT row_date, acdcalls, split, logid, acdtime, i_stafftime
        FROM [RepGateDB].[CmsClalit].[hagent]
		WHERE row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL) AS HA
  INNER JOIN ( SELECT *
               RepGateWorkers.dbo.fn_GenericAgentsList(@tDate,@tDate)  
			   WHERE MokedID IN (@MokedID)) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE SkillSubGroup LIKE ('%מידע%')
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;
  
   -- חיפוש שיחות של נציגי צק פוסט בכל הסקילים ---
  DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @tDate AS DATE
  
  SET @tDate=GETDATE()
  SET @MokedID=5759
  SET @sDateCalls='2021-10-10'
  SET @eDateCalls='2021-10-19'
  
  SELECT 
       ID_CardNum
       ,logid
       ,FullNameHeb
       ,CrewName
      ,SUM(acdcalls) AS acdcalls
      ,SUM(CAST(acdtime AS Float)/3600/24) / SUM(acdcalls) AS acdtimeaverage
      ,SUM(ROUND(CAST(i_stafftime AS Float)/3600,2)) AS loginX
      ,ROUND(SUM(acdcalls) / SUM(ROUND(CAST(i_stafftime AS Float)/3600,2)),2) AS numberofcalls
      ,CAST(CAST(SUM(CAST(acdtime AS Float)/3600) / SUM(ROUND(CAST(i_stafftime AS Float)/3600,2))*100 as decimal(18,2)) as varchar(6)) + ' %' as TaasukaX
  FROM [RepGateDB].[CmsClalit].[hagent] AS HA
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@tDate,@tDate) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL AND MokedID IN (@MokedID) 
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;
  
-- חיפוש נציגי צק פוסט ---
DECLARE @DivX AS Integer
DECLARE @MokedID AS Integer
DECLARE @sDate AS VARCHAR(10)
DECLARE @eDate AS VARCHAR(10)
 
DECLARE @tDate as date
SET @tDate=GetDate()
  
SET @DivX=3100
SET @MokedID=3105

select * from RepGateWorkers.dbo.fn_GenericAgentsList(@tDate,@tDate)
WHERE ProjectID IN (@DivX) AND MokedID IN (@MokedID);

-- חיפוש נציגי תקשוב מהבית כללית ---
DECLARE @DivX AS Integer
DECLARE @MokedID AS Integer
DECLARE @sDate AS VARCHAR(10)
DECLARE @eDate AS VARCHAR(10)
 
DECLARE @tDate as date
SET @tDate=GetDate()
  
SET @DivX=440
SET @MokedID=4449

select * from RepGateWorkers.dbo.fn_GenericAgentsList(@tDate,@tDate)
WHERE ProjectID IN (@DivX) AND MokedID IN (@MokedID);

--- חיפוש תקשוב מהבית בשפות רוסית ---
 DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @tDate AS DATE
  
  SET @tDate=GETDATE()
  SET @MokedID=4449
  SET @sDateCalls='2021-04-13'
  SET @eDateCalls='2021-10-13'
  
  SELECT 
       ID_CardNum
       ,logid
       ,FullNameHeb
       ,CrewName
      ,SUM(acdcalls) AS acdcalls
      ,SUM(acdtime) AS acdcalls
      ,SUM(CAST(acdtime AS Float)/3600/24) / SUM(acdcalls) AS acdtimeaverage
      ,SUM(ROUND(CAST(i_stafftime AS Float)/3600,2)) AS loginX
      ,ROUND(SUM(acdcalls) / SUM(ROUND(CAST(i_stafftime AS Float)/3600,2)),2) AS numberofcalls
      ,CAST(CAST(SUM(CAST(acdtime AS Float)/3600) / SUM(ROUND(CAST(i_stafftime AS Float)/3600,2))*100 as decimal(18,2)) as varchar(6)) + ' %' as TaasukaX
  FROM [RepGateDB].[CmsClalit].[hagent] AS HA
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@tDate,@tDate) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL AND MokedID IN (@MokedID) AND LanguageX LIKE ('%רוסית%')
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;
