SELECT TOP 1000 DateX
FROM [CenterPointLamas].[order]
WHERE DateX = CONVERT(VARCHAR(10), GETDATE() - 1, 111)

SELECT TOP 1000 DateX
FROM [CenterPointLamas].[order_fields_product_1]
WHERE DateX = CONVERT(VARCHAR(10), GETDATE() - 1, 111)

SELECT TOP 1000 DateX
FROM [CenterPointLamas].[user_login_stats]
WHERE DateX = CONVERT(VARCHAR(10), GETDATE() - 1, 111)

SELECT TOP 1000 DateX
FROM [CenterPointLamas].[cdr]
WHERE DateX = CONVERT(VARCHAR(10), GETDATE() - 1, 111)

SELECT TOP 1000 DateX
FROM [CenterPointLamas].[queue_log]
WHERE DateX = CONVERT(VARCHAR(10), GETDATE() - 1, 111)
