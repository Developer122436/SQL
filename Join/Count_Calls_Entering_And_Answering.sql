 DECLARE @sDateAgent AS VARCHAR(10)
  DECLARE @eEndAgent AS VARCHAR(10)
  
  SET @sDateAgent='2021-06-01'
  SET @eEndAgent='2022-03-31'

  SELECT 
       convert(varchar(7), row_date, 126) AS 'חודש ושנה'
	   ,HS.logid
	   ,GA.FullNameHeb
	   ,GA.Skill3
	   ,WO.LanguageX
	   ,GA.CityX
	   ,SK.Skill
	   ,SK.SkillSubGroup
	   ,SK.SkillGroup
	   ,SK.SkillNameHeb
   ,COUNT(DISTINCT HS.logid) AS 'כמות נציגים ברוסית'
   ,ISNULL(SUM(acdcalls),0) + ISNULL(SUM(abncalls),0) AS 'כמות שיחות נכנסות כוללת ברוסית'
      ,ISNULL(SUM(acdcalls),0) AS 'כמות שיחות נענות כוללת ברוסית'
  FROM 
      (
        SELECT *
FROM [CmsClalit].hagent
WHERE row_date between @sDateAgent and @eEndAgent
  ) HS
  INNER JOIN [CmsClalit].[Skills] SK ON HS.split = SK.Skill 
  INNER JOIN RepGateWorkers.dbo.fn_GenericAgentsList(@sDateAgent,@eEndAgent) AS GA ON HS.logid = GA.LoginID 
  INNER JOIN [RepGateWorkers].[dbo].[Workers] AS WO ON WO.ID_CardNum = GA.ID_CardNum
  WHERE SK.Skill IN (113,130,263,271,612,622,632,212,217,432,472)
  GROUP BY convert(varchar(7), row_date, 126), HS.logid, GA.FullNameHeb, SK.Skill, GA.Skill3, GA.CityX, SK.SkillSubGroup, WO.LanguageX, SK.SkillGroup, SK.SkillNameHeb
  ORDER BY convert(varchar(7), row_date, 126) DESC