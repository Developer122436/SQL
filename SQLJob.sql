SELECT A.*

INTO   #temp
FROM   (
                 SELECT    TT.datex,
                           TT.ucid,
                           TT.sessionid,
                           TT.tz
                 FROM      (
                                  SELECT datex,
                                         ucid,
                                         sessionid,
                                         tz,
                                         startdatetime
                                  FROM   repgatedb.cmsclalit.ivr
                                  WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22'
                                  AND    queuedate IS NOT NULL ) AS TT
                 LEFT JOIN
                           (
                                  SELECT sessionid,
                                         hunguppoint
                                  FROM   repgatedb.cmsclalit.ivr
                                  WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22'
                                  AND    hunguppoint IS NOT NULL ) AS RR
                 ON        TT.sessionid = RR.sessionid
                 LEFT JOIN
                           (
                                     SELECT    IVR.*,
                                               VDN.vdn_group,
                                               VDN.vdn_id
                                     FROM      (
                                                      SELECT vdn,
                                                             sessionid
                                                      FROM   repgatedb.cmsclalit.ivr
                                                      WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22'
                                                      AND    module = 'R1TRANSFER'
                                                      AND    hunguppoint IS NULL ) AS IVR
                                     LEFT JOIN
                                               (
                                                      SELECT vdn_id,
                                                             vdn_group
                                                      FROM   repgatedb.cmsclalit.vdns ) AS vdn
                                     ON        IVR.vdn = vdn.vdn_id ) AS UU
                 ON        TT.sessionid = UU.sessionid
                 WHERE     UU.vdn_group IN('מידע ושירות',
                                           'גיבוי אחיות',
                                           'מידע ושירות תמיכה',
                                           'מידע ושירות חיילים',
                                           'מושלם')
                 OR        RR.hunguppoint IS NOT NULL ) AS A;CREATE TABLE #data1
             (
                          datex                    DATE,
                          callsenterintonatav      INT,
                          callsplayedreminder      INT,
                          hungupinremindermodel    INT,
                          totalhungupafterreminder INT
             );INSERT INTO #data1
SELECT    A.datex,
          Isnull(B.[סך שיחות נכנסות לנתב], 0)                  AS 'סך שיחות נכנסות לנתב',
          Isnull(C.[סך שיחות שהשמועה להם תזכורת], 0)     AS 'סך שיחות שהשמועה להם תזכורת',
          Isnull(D.[ניתוק במודל תזכורת], 0)                     AS 'ניתוק במודל תזכורת',
          Isnull(E.[סך ניתוקים לאחר השמעת תזכורות], 0) AS 'סך ניתוקים לאחר השמעת תזכורות'
FROM      (
                 SELECT datex
                 FROM   repgatedb.dbo.days
                 WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22' ) AS A
LEFT JOIN
          (
                   SELECT   datex,
                            Count(DISTINCT sessionid) AS 'סך שיחות נכנסות לנתב'
                   FROM     repgatedb.cmsclalit.ivr
                   WHERE    datex BETWEEN '2022-05-22' AND      '2022-05-22'
                   GROUP BY datex ) AS B
ON        A.datex = B.datex
LEFT JOIN
          (
                   SELECT   A.datex,
                            Count(*) AS 'סך שיחות שהשמועה להם תזכורת'
                   FROM     (
                                            SELECT DISTINCT datex,
                                                            ucid,
                                                            sessionid,
                                                            tz
                                            FROM            repgatedb.cmsclalit.ivr
                                            WHERE           datex BETWEEN '2022-05-22' AND             '2022-05-22'
                                            AND             queuedate IS NOT NULL ) AS A
                   GROUP BY A.datex ) AS C
ON        A.datex = C.datex
LEFT JOIN
          (
                   SELECT   datex,
                            Count(*) AS 'ניתוק במודל תזכורת'
                   FROM     repgatedb.cmsclalit.ivr
                   WHERE    datex BETWEEN '2022-05-22' AND      '2022-05-22'
                   AND      queuedate IS NOT NULL
                   AND      hunguppoint IS NOT NULL
                   GROUP BY datex ) AS D
ON        A.datex = D.datex
LEFT JOIN
          (
                   SELECT   A.datex,
                            Count(*) AS 'סך ניתוקים לאחר השמעת תזכורות'
                   FROM     (
                                            SELECT DISTINCT datex,
                                                            ucid,
                                                            sessionid,
                                                            tz
                                            FROM            #temp ) AS A
                   GROUP BY A.datex ) AS E
ON        A.datex = E.datex;CREATE TABLE #t1
             (
                          datex     DATE,
                          ucid      VARCHAR(50),
                          sessionid VARCHAR(50),
                          tz        VARCHAR(20),
                          starttime TIME
             );INSERT INTO #t1
SELECT   datex,
         ucid,
         sessionid,
         tz,
         CONVERT( TIME, Min(startdatetime)) AS StartTime
FROM     repgatedb.cmsclalit.ivr
WHERE    datex BETWEEN '2022-05-22' AND      '2022-05-22'
AND      queuedate IS NOT NULL
GROUP BY datex,
         ucid,
         sessionid,
         tz;CREATE TABLE #t2
             (
                          datex       DATE,
                          ucid        VARCHAR(50),
                          sessionid   VARCHAR(50),
                          tz          VARCHAR(20),
                          hunguppoint VARCHAR(50),
                          vdngroup    VARCHAR(50)
             );INSERT INTO #t2
SELECT    TT.datex,
          TT.ucid,
          TT.sessionid,
          TT.tz,
          RR.hunguppoint,
          UU.vdn_group
FROM      (
                 SELECT datex,
                        ucid,
                        sessionid,
                        tz,
                        startdatetime
                 FROM   repgatedb.cmsclalit.ivr
                 WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22'
                 AND    queuedate IS NOT NULL ) AS TT
LEFT JOIN
          (
                 SELECT sessionid,
                        hunguppoint
                 FROM   repgatedb.cmsclalit.ivr
                 WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22'
                 AND    hunguppoint IS NOT NULL ) AS RR
ON        TT.sessionid = RR.sessionid
LEFT JOIN
          (
                    SELECT    IVR.vdn,
                              IVR.sessionid,
                              VDN.vdn_group,
                              VDN.vdn_id
                    FROM      (
                                     SELECT vdn,
                                            sessionid
                                     FROM   repgatedb.cmsclalit.ivr
                                     WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22'
                                     AND    module = 'R1TRANSFER'
                                     AND    hunguppoint IS NULL ) AS IVR
                    LEFT JOIN
                              (
                                     SELECT vdn_id,
                                            vdn_group
                                     FROM   repgatedb.cmsclalit.vdns ) AS vdn
                    ON        IVR.vdn = vdn.vdn_id ) AS UU
ON        TT.sessionid = UU.sessionid
WHERE     vdn_group IN('מידע ושירות',
                       'גיבוי אחיות',
                       'מידע ושירות תמיכה',
                       'מידע ושירות חיילים',
                       'מושלם')
OR        RR.hunguppoint IS NOT NULL;CREATE TABLE #t3
             (
                          datex      DATE,
                          sessionid  VARCHAR(50),
                          iscanceled BIT
             );INSERT INTO #t3
SELECT datex,
       sessionid,
       iscanceled
FROM   repgatedb.cmsclalit.cancelqueue
WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22';CREATE TABLE #data2
             (
                          datex                    DATE,
                          reminderlistening        INT,
                          reminderlisteninginnatav INT,
                          cancelinnatav            INT,
                          canceloutnatav           INT
             );INSERT INTO #data2
SELECT   B1.datex,
         Count(*)         AS ReminderListening,
         Sum(B1.endafter) AS ReminderListeningInNatav,
         Sum(
         CASE
                  WHEN B1.endafter = 1
                  AND      B1.cancelq = 1 THEN 1
                  ELSE 0
         END) AS CancelInNatav,
         Sum(
         CASE
                  WHEN B1.endafter = 0
                  AND      B1.cancelq = 1 THEN 1
                  ELSE 0
         END) AS CancelOutNatav
FROM     (
                   SELECT    A1.datex,
                             Cast(A1.datex AS DATETIME) + Cast(A1.starttime AS DATETIME) AS DATETIME,
                             A1.ucid,
                             A1.sessionid,
                             A1.tz,
                             CASE
                                       WHEN A2.sessionid IS NULL THEN 0
                                       ELSE 1
                             END AS EndAfter,
                             CASE
                                       WHEN A3.datex < '2017-02-13' THEN(
                                                 CASE
                                                           WHEN A2.sessionid IS NULL THEN 0
                                                           ELSE 1
                                                 END)
                                       ELSE(
                                                 CASE
                                                           WHEN Isnull(A3.iscanceled, 0) = 0 THEN 0
                                                           ELSE 1
                                                 END)
                             END AS CancelQ
                   FROM      (
                                    SELECT *
                                    FROM   #t1 ) AS A1
                   LEFT JOIN
                             (
                                             SELECT DISTINCT datex,
                                                             ucid,
                                                             sessionid,
                                                             tz
                                             FROM            #t2 ) AS A2
                   ON        A1.sessionid = A2.sessionid
                   LEFT JOIN
                             (
                                    SELECT datex,
                                           sessionid,
                                           iscanceled
                                    FROM   #t3 ) AS A3
                   ON        A1.sessionid = A3.sessionid ) AS B1
GROUP BY B1.datex
ORDER BY B1.datex;

SELECT   *
FROM     (
                   SELECT    CONVERT( VARCHAR, [A1].[datex], 103)                                                                                    AS [DateX],
                             [A1].[daynamex]                                                                                                         AS [DayNameX],
                             Isnull([A2].[callsenterintonatav], 0)                                                                                   AS [totalInNatav],
                             Isnull([A2].[callsplayedreminder], 0)                                                                                   AS [CallsPlayedReminder],
                             Isnull([A2].[hungupinremindermodel], 0)                                                                                 AS [HungUpInReminderModel],
                             Isnull(Cast([A3].[cancelinnatav] AS NUMERIC(30, 2)), 0) / NULLIF([a3].[canceloutnatav] + [a3].[cancelinnatav], 0)       AS [cancelInNatavPer],
                             Isnull([A3].[cancelinnatav], 0)                                                                                         AS [CancelInNatav],
                             Isnull([A2].totalhungupafterreminder, 0)                                                                                AS [CancelOutNatav],
                             Cast(Isnull([a3].[canceloutnatav] + [a3].[cancelinnatav], 0) AS NUMERIC(30, 2)) / NULLIF([A2].[callsplayedreminder], 0) AS [moveToCancelTorPr],
                             Isnull([a3].[canceloutnatav] + [a3].[cancelinnatav], 0)                                                                 AS [moveToCancelTor],
                             Cast(Isnull([A2].[callsplayedreminder], 0) AS NUMERIC(30, 2))   / NULLIF([A2].[callsenterintonatav], 0)                   AS [CallsPlayedReminderPr],
                             Isnull(Cast([A2].[hungupinremindermodel] AS  NUMERIC(30, 2)), 0) / NULLIF([A2].[callsplayedreminder], 0)                   AS [HungUpInReminderModelPer],
                             Isnull(Cast([A2].totalhungupafterreminder AS NUMERIC(30, 2)), 0) / NULLIF([A2].[callsenterintonatav], 0)                   AS [CancelOutNatavPe]
                   FROM      (
                                    SELECT datex,
                                           daynamex
                                    FROM   repgatedb.dbo.days
                                    WHERE  datex BETWEEN '2022-05-22' AND    '2022-05-22' ) AS A1
                   LEFT JOIN
                             (
                                    SELECT *
                                    FROM   #data1 ) AS A2
                   ON        A1.datex = A2.datex
                   LEFT JOIN
                             (
                                    SELECT *
                                    FROM   #data2 ) AS A3
                   ON        A1.datex = A3.datex ) AS temp
ORDER BY temp.datex;DROP TABLE #data2;DROP TABLE #t3;DROP TABLE #t2;DROP TABLE #t1;DROP TABLE #data1;DROP TABLE #temp;