/**cmsclalit בדיקת סקילים עם   **/
SELECT Split, SkillNameHeb, SUM(acdcalls) AS 'כמות נענות', SkillGroup, SkillSubGroup, CASE WHEN SK.Skill IS NOT NULL THEN 'קיים' ELSE 'לא קיים' END AS 'cmsclalitקיים ב'
FROM
    (SELECT Split, acdcalls
     FROM [CmsClalit].[hsplit]
	 WHERE acdcalls IS NOT NULL) AS HS
LEFT JOIN [CmsClalit].[Skills] AS SK ON SK.Skill = HS.split
GROUP BY Split, SkillGroup, SkillSubGroup, SkillNameHeb, SK.Skill
ORDER BY SUM(acdcalls) DESC