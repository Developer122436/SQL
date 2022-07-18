  CREATE VIEW Time_of_Transfers AS
  
  SELECT CONVERT(time,CONVERT(varchar(2),DATEPART(HH,StartDateTime))+':'+CONVERT(varchar(2),(DATEPART(MI,StartDateTime)-DATEPART(MI,StartDateTime)%30))+':00'),    
       COUNT(CONVERT(CHAR(10), StartDateTime, 108))    
  FROM [RepGateDB].[CmsClalit].[InteractionSummaryAgent]    
  WHERE CAST(CONVERT(CHAR(8),StartDateTime,112) AS DATE) = CONVERT(DATE, CONVERT(VARCHAR(10), DATEADD(DAY, DATEDIFF(DAY, -1, GETDATE()), -1), 111)) 
  AND CONVERT(CHAR(10), StartDateTime, 108) >= '07:00:00' AND ToAddress IN ('768628715')   
  GROUP BY CONVERT(time,CONVERT(varchar(2),DATEPART(HH,StartDateTime))+':'+CONVERT(varchar(2),(DATEPART(MI,StartDateTime)-DATEPART(MI,StartDateTime)%30))+':00')    
  ORDER BY CONVERT(time,CONVERT(varchar(2),DATEPART(HH,StartDateTime))+':'+CONVERT(varchar(2),(DATEPART(MI,StartDateTime)-DATEPART(MI,StartDateTime)%30))+':00')  
