CREATE TABLE #Invoices (
    InvoiceDate Date,
    list_price int
);

INSERT INTO #Invoices VALUES
('2022-12-01', 1), ('2023-02-01', 1), ('2023-02-15', 1),
('2023-03-01', 3), ('2023-04-01', 2), ('2023-04-15', 2),
('2023-05-01', 5), ('2023-06-01', 3), ('2023-06-15', 3), 
('2023-08-01', 8), ('2023-09-01', 1), ('2023-10-01', 2),
('2023-11-01', 3), ('2023-12-01', 4), ('2024-01-01', 1);

SELECT * 
FROM #Invoices

DROP TABLE #Invoices