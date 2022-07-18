  DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)

  SET @sDateAgent='2022-02-27'
  SET @eEndAgent='2022-03-12'

SELECT 
WIS.Username + convert(varchar(10),CF.DateX,103) AS 'עמודת עזר',
WIS.Username AS 'יוזר סיבל'
,convert(varchar(10),CF.DateX,103) AS 'תאריך'
,PAL.ID_CardNum
,PAL.FullNameHeb
,PAL.MokedName
    ,MIN(convert(varchar(8),Login,108)) AS 'כניסה'
    ,MAX(convert(varchar(8),Logout,108)) AS 'יציאה'
FROM (
  SELECT DateX, LoginID, Login, Logout
  FROM Logins.CmsClalitFixed
      WHERE DateX between @sDateAgent and @eEndAgent
) CF
INNER JOIN (
SELECT ID_CardNum, LoginID, FullNameHeb, MokedName
From RepGateWorkers.dbo.fn_GenericAgentsList(@sDateAgent,@eEndAgent) 
WHERE MokedID IN(
3102,
3105,
3106,
299,
3115,
3121,
3124,
3107,
5759,
3101,
1619,
4449
)) PAL ON CF.LoginID = PAL.LoginID 
INNER JOIN (
  SELECT ID_CardNum, Username, SystemID
  FROM RepGateWorkers.dbo.WorkersInSystems
  WHERE SystemID = 1 AND DateOut IS NULL
) WIS ON PAL.ID_CardNum = WIS.ID_CardNum 
GROUP BY WIS.Username, CF.DateX, PAL.ID_CardNum, PAL.FullNameHeb, PAL.MokedName, WIS.Username
ORDER BY CF.DateX DESC, MIN(convert(varchar(8),Login,108)) 
