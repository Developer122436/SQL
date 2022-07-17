    /**** שאילתא להוצאת נתוני זימון,מידע,בילינג ואונליין של מוקד מידע ושירות כללית ****/
  DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)
  
  SET @MokedID=3105
  SET @sDateCalls='2022-02-01'
  SET @eDateCalls='2022-02-10'
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
  FROM [RepGateDB].[CmsClalit].[hagent] AS HA
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@sDateAgent,@eEndAgent) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE (row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL AND MokedID IN (@MokedID) AND Skill IN(110,120,169,161,130,140,263,262,166,264,210,208,211,213,212,429,430,431,432,433,254,460,470,471,472,473,479)) 
  GROUP BY ID_CardNum, logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;

    /**** שאילתא להוצאת נתוני אונליין של מוקד מידע ושירות כללית ****/
  DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)
  
  SET @MokedID=3105
  SET @sDateCalls='2022-02-01'
  SET @eDateCalls='2022-02-10'
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
  FROM [RepGateDB].[CmsClalit].[hagent] AS HA
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@sDateAgent,@eEndAgent) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE (row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL AND MokedID IN (@MokedID) AND Skill IN(254,460,470,471,472,473,479)) 
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;

    /**** שאילתא להוצאת נתוני בילינג של מוקד מידע ושירות כללית ****/
  DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)
  
  SET @MokedID=3105
  SET @sDateCalls='2022-02-01'
  SET @eDateCalls='2022-02-10'
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
  FROM [RepGateDB].[CmsClalit].[hagent] AS HA
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@sDateAgent,@eEndAgent) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE (row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL AND MokedID IN (@MokedID) AND Skill IN(429,430,431,432,433)) 
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;

    /**** שאילתא להוצאת נתוני מידע של מוקד מידע ושירות כללית ****/
  DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)
  
  SET @MokedID=3105
  SET @sDateCalls='2022-02-01'
  SET @eDateCalls='2022-02-10'
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
  FROM [RepGateDB].[CmsClalit].[hagent] AS HA
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@sDateAgent,@eEndAgent) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE (row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL AND MokedID IN (@MokedID) AND Skill IN(210,208,211,213,212)) 
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;

  /**** שאילתא להוצאת נתוני זימון של מוקד מידע ושירות כללית ****/
  DECLARE @MokedID AS Integer
  DECLARE @sDateCalls AS VARCHAR(10)
  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eDateCalls AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)
  
  SET @MokedID=3105
  SET @sDateCalls='2022-02-01'
  SET @eDateCalls='2022-02-10'
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
  FROM [RepGateDB].[CmsClalit].[hagent] AS HA
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@sDateAgent,@eEndAgent) AS AL ON AL.LoginID = HA.logid
  INNER JOIN RepGateDB.CmsClalit.Skills AS SK ON SK.Skill = HA.split 
  WHERE (row_date between @sDateCalls and @eDateCalls AND [acdcalls] IS NOT NULL AND MokedID IN (@MokedID) AND Skill IN(110,120,169,161,130,140,263,262,166,264)) 
  GROUP BY logid, ID_CardNum, FullNameHeb, CrewName
  ORDER BY FullNameHeb;