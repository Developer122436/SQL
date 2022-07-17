/**cmsclalit בדיקת סקילים עם   **/
SELECT Split, SkillGroup, SkillSubGroup, SkillNameHeb, SUM(acdcalls) AS 'כמות נענות'
FROM
    (SELECT Split, acdcalls
     FROM [CmsClalit].[hsplit]
	 WHERE acdcalls IS NOT NULL) AS HS
INNER JOIN [CmsClalit].[Skills] AS SK ON SK.Skill = HS.split
GROUP BY Split, SkillGroup, SkillSubGroup, SkillNameHeb
ORDER BY SUM(acdcalls) DESC

/** hsplit בדיקת סקילים בכל  **/
SELECT Split, SUM(acdcalls) AS 'כמות נענות'
FROM [CmsClalit].[hsplit]
WHERE acdcalls IS NOT NULL
GROUP BY Split
ORDER BY SUM(acdcalls) DESC

/**cmsclalit בדיקת סקילים שלא קיימים בטבלת   **/
SELECT Split, SUM(acdcalls) AS 'כמות נענות'
FROM
    (SELECT Split, acdcalls
     FROM [CmsClalit].[hsplit]
	 WHERE acdcalls IS NOT NULL) AS HS
LEFT JOIN [CmsClalit].[Skills] AS SK ON SK.Skill = HS.split
WHERE SK.Skill IS NULL
GROUP BY Split, SkillGroup, SkillSubGroup, SkillNameHeb
ORDER BY SUM(acdcalls) DESC