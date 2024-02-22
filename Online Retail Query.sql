Select *
From [Online Retail]..['Online Retail$']

Select Count(distinct(InvoiceNo)), count(Distinct(StockCode))
From [Online Retail]..['Online Retail$']

Select Count(Distinct(StockCode)), Count(Distinct(UnitPrice))
From [Online Retail]..['Online Retail$']

Select Count(distinct(Country)), Count(distinct(CustomerID))
From [Online Retail]..['Online Retail$']

Select max(InvoiceDate)
From [Online Retail]..['Online Retail$']


--Revenue Calculations
 Select InvoiceNo, InvoiceDate
StockCode, Quantity, 
UnitPrice,
CustomerID, 
Country,
(Quantity*UnitPrice) as Amount
From [Online Retail]..['Online Retail$']


--Revenue by Countries
WITH Amount_CTE as
( Select InvoiceNo,
StockCode, Quantity, 
UnitPrice,
CustomerID, 
Country,
(Quantity*UnitPrice) as Amount
From [Online Retail]..['Online Retail$']
)
Select Country, Round(Sum(Amount),0) as [Total Revenue]
From Amount_CTE
Group by Country

--Revenue by Customer
WITH Amount_CTE as
( Select InvoiceNo,
StockCode, Quantity, 
UnitPrice,
CustomerID, 
Country,
(Quantity*UnitPrice) as Amount
From [Online Retail]..['Online Retail$']
)
Select distinct(CustomerID), Round(Sum(Amount),0) as [Total Revenue]
From Amount_CTE
Group by CustomerID

--Revenue by Stock
WITH Amount_CTE as
( Select InvoiceNo,
StockCode, Quantity, 
UnitPrice,
CustomerID, 
Country,
(Quantity*UnitPrice) as Amount
From [Online Retail]..['Online Retail$']
)
Select distinct(StockCode), Round(Sum(Amount),0) as [Total Revenue]
From Amount_CTE
Where Amount > 0
Group by StockCode

-- Quantitiy Sold per Stock Code
Select Distinct(StockCode),
COUNT(StockCode) Over (Partition by StockCode) as [Number of Product Sold]
From [Online Retail]..['Online Retail$']
Where Description is not Null and 
UnitPrice > 0

--Different Products Sold per Country
Select Distinct(Country),
COUNT(StockCode) Over (Partition by Country) as [Number of Product Sold]
From [Online Retail]..['Online Retail$']
Where Description is not Null and 
UnitPrice > 0
Order by Country 

--Total Quantity Sold per Country
With Quantity_CTE as 
(
Select *, 
Sum(Quantity) OVER (Partition by Country) as [Quantity Sold]
From [Online Retail]..['Online Retail$']
)
Select country,Avg([Quantity Sold]) as [Total Number of Units Sold]
From Quantity_CTE
Group by Country

--Total Quantity Sold Per Stock Code
With Quantity_CTE as 
(
Select *,
Sum(Quantity) OVER (Partition by StockCode) as [Quantity Sold]
From [Online Retail]..['Online Retail$']
)
Select StockCode,Avg([Quantity Sold]) as [Total Number of Units Sold]
From Quantity_CTE
Group by StockCode
Order by StockCode

--Total Quantity Sold per Customer
With Quantity_CTE as 
(
Select *,
Sum(Quantity) OVER (Partition by CustomerID) as [Quantity Sold]
From [Online Retail]..['Online Retail$']
)
Select CustomerID, Avg([Quantity Sold]) as [Total Number of Units Sold]
From Quantity_CTE
Group by CustomerID

--Revenue by Invoice
WITH Amount_CTE as
( Select InvoiceNo,
StockCode, Quantity, 
UnitPrice,
CustomerID, 
Country,
(Quantity*UnitPrice) as Amount
From [Online Retail]..['Online Retail$']
)
Select InvoiceNo, Round(Sum(Amount),0) as [Total Revenue]
From Amount_CTE
Group by InvoiceNo


--Total Quantity sold per Country
With Quantity_CTE as
(
Select *, 
Sum(Quantity) Over (Partition by Country) as QuantitySold
From [Online Retail]..['Online Retail$']
)
Select Country, Avg(QuantitySold) as [Total Units Sold]
From Quantity_CTE
Group by Country

--Revenue by Product per Country
WITH Amount_CTE as
( Select InvoiceNo,
StockCode, Quantity, 
UnitPrice,
CustomerID, 
Country,
(Quantity*UnitPrice) as Amount
From [Online Retail]..['Online Retail$']
)
Select distinct(StockCode), Country, Round(Sum(Amount),0) as [Total Revenue]
From Amount_CTE
Where Amount > 0
Group by StockCode, Country
Order by StockCode
 