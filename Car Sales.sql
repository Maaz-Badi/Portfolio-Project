Select * 
From [Portfolia Project ]..['Car Sales']

Select Car_id, [Customer Name]
From [Portfolia Project ]..['Car Sales']
Order by Car_id

--Creating a Column of Year
Select *, Year(Date)
From [Portfolia Project ]..['Car Sales']

Alter Table ['Car Sales']
Add [Year] nvarchar(20);
Update ['Car Sales']
Set [Year] = Year(Date)

--Creating a Column of Month 
Select *, DATENAME(MONTH, Date) as [Month]
From [Portfolia Project ]..['Car Sales']

Alter Table ['Car Sales']
Add [Month] nvarchar(20);
Update ['Car Sales']
Set [Month] = DATENAME(MONTH, Date)


--Average Price by Company
Select Company, Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by Company
Order by [Average Price] desc
-----------------------------

--Average Price by Body Type
Select [Body Style], Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by [Body Style]
Order by [Average Price] desc
-----------------------------

--Average Price per Model
Select Model, Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by Model
Order by [Average Price] desc
-----------------------------

--Average Price per Gender
Select Gender, Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by Gender
Order by [Average Price] desc
------------------------------

--Average Price per Transmission
Select Transmission, Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by Transmission
Order by [Average Price] desc
-------------------------------

--Average Price per Region
Select Dealer_Region, Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by Dealer_Region
Order by [Average Price] desc
-----------------------------

--Average Price per Engine
Select Engine, Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by Engine
Order by [Average Price] desc
-----------------------------

--Average Price per Dealer
Select Dealer_Name, Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by Dealer_Name
Order by [Average Price] desc
----------------------------

--Monthly Average Price per Company
Select  Company,[Year], [Month], Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Where [Year] = '2023'
Group by Company, [Year], [Month] 
Order by Company, [Year], [Month]
---------------------------------

--Monthly Average Price per Dealer of Every Company
Select Company, Dealer_Name ,[Year], [Month],  Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Where [Year] = '2023'
Group by Company, Dealer_Name, [Year], [Month]
Order by Company, Dealer_Name, [Year], [Month]


--Monthly Average Price by Body Type
Select [Body Style],[Year], [Month], Round(AVG([Price ($)]),2) as [Average Price]
From [Portfolia Project ]..['Car Sales']
Group by [Body Style],[Year], [Month]
Order by [Body Style],[Year], [Month]


--Number of Sales per Model of Every Company
Select Company, Model, Count(Model) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Model
Order by Company, Model
-------------------

--Number of Sales per Company
Select Company, Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company
Order by Company 

--Number of Sales per Body Type of Every Company
Select Company, [Body Style], Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, [Body Style]
Order by Company, [Body Style]

--Number of Sales per Dealer of Every Company
Select Company, Dealer_Name, Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Dealer_Name
Order by Company, Dealer_Name 

--To do the same thing as above but with a rolling count of total company sales
WITH SS_CTE as 
(
Select Company, Dealer_Name, [Dealer_No ], Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Dealer_Name, [Dealer_No ]
--Order by Company, Dealer_Name, [Dealer_No ]
)
Select *, Sum([Number of Sales]) OVER (Partition by Company Order by Dealer_Name) as [Total Company Sales]
From SS_CTE

----Number of Sales of Model per Dealer of Every Company
Select Company, Dealer_Name, Model, Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Dealer_Name,Model
Order by Company, Dealer_Name, Model

--To do the same thing as above but without Company Names and Company as a filter(Where Clause)
Select Dealer_Name, Model, Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Where Company = 'Audi'
Group by Dealer_Name, Model
Order by Dealer_Name, Model

----Number of Sales of Body Types per Dealer of Every Company
Select Company, Dealer_Name, [Body Style], Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Dealer_Name,[Body Style]
Order by Company, Dealer_Name, [Body Style]

--Number of Sales of Body Types
Select Company, Year, Month,  Dealer_Name, [Body Style], Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company,Year, Month, Dealer_Name,[Body Style]
Order by Company,Year, Month, Dealer_Name, [Body Style]

--Number of Sales of Model of Company
Select Company, Model, Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company,Model
Order by Company,Model

--Number of Sales of Model
Select Company, Year, Month, 
Dealer_Region, Dealer_Name, 
[Body Style], Model, Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Year, Month, 
Dealer_Region, Dealer_Name, 
[Body Style], Model
Order by Company, Year, Month, 
Dealer_Region, Dealer_Name, 
[Body Style], Model

--Number of Sales of Body Type
Select Company, Year, Month, 
Dealer_Region, Dealer_Name, 
[Body Style], Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Year, Month, 
Dealer_Region, Dealer_Name, 
[Body Style]
Order by Company, Year, Month, 
Dealer_Region, Dealer_Name, 
[Body Style]

--Monthly Sales 
Select Company, Year, Month, Count(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Year, Month
Order by Company, Year, Month

--Regional Sales
Select Company, Year, Dealer_Region, COUNT(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Year, Dealer_Region
Order by Company, Year, Dealer_Region

--Dealer Sales
Select Company, Year, Dealer_Name, COUNT(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Year, Dealer_Name
Order by Company, Year, Dealer_Name

--Total Sales
Select Company, Year, COUNT(*) as [Number of Sales]
From [Portfolia Project ]..['Car Sales']
Group by Company, Year
Order by Company, Year

---------REVENUE-------------
--Revenue by Body Type of Each Company Every Year & Percentage of total Revneue 
DROP TABLE IF EXISTS [REVENUE%]
CREATE TABLE [Revenue%]
(
Company nvarchar (50),
Year nvarchar(50),
Month nvarchar(50),
[Revenue by Body Style] int,
)

Insert INTO [Revenue%]
Select Company, Year, [Body Style], Sum([Price ($)])as [Revenue by Body Style]
from [Portfolia Project ]..['Car Sales']
Group by Company, Year, [Body Style]
Order by Company, Year, [Body Style]

WITH YY_CTE as 
(
Select *,Sum(Convert(bigint,[Revenue by Body Style])) OVER (Partition by Company, year) as [Company Revenue]
From [Revenue%]
)
Select *, Round(Convert(float, [Revenue by Body Style])/Convert(float, [Company Revenue])*100,3) as [Perventage of Revenue]
From YY_CTE

----Revenue by Month of Each Company Every Year & Percentage of total Revneue 
DROP TABLE IF EXISTS [REVENUE%]
CREATE TABLE [Revenue%]
(
Company nvarchar (50),
Year nvarchar(50),
Month nvarchar(50),
[Revenue by Month] int,
)

Insert INTO [Revenue%]
Select Company, Year, Month, Sum([Price ($)])as [Revenue by Month]
from [Portfolia Project ]..['Car Sales']
Group by Company, Year, Month
Order by Company, Year, Month

WITH YY_CTE as 
(
Select *,Sum(Convert(bigint,[Revenue by Month])) OVER (Partition by Company, year) as [Company Revenue]
From [Revenue%]
)
Select *, Convert(float, [Revenue by Month])/Convert(float, [Company Revenue])*100 as [Perventage of Revenue]
From YY_CTE