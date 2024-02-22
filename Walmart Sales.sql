Select * 
From [Walmart Sales]..WalmartSalesData#csv$

--Creating Column Time of Day
Select convert(time, Time) as [Time], 
(CASE When convert(time, Time)  Between '00:00:00' and '12:00:00' Then 'Morning'
      When convert(time, Time)  Between '12:00:01' and '16:00:00' Then 'Afternoon'
	  Else 'Evening'
	  END
	  ) as [Time of the Day]
From [Walmart Sales]..WalmartSalesData#csv$

Alter Table dbo.WalmartSalesData#csv$ Add Time_of_Day nvarchar(20);
Update dbo.WalmartSalesData#csv$
Set Time_of_Day = (CASE When convert(time, Time)  Between '00:00:00' and '12:00:00' Then 'Morning'
      When convert(time, Time)  Between '12:00:01' and '16:00:00' Then 'Afternoon'
	  Else 'Evening'
	  END
	  );



--Creating Column Day of the Week

Select Date, DATENAME(WEEKDAY, convert(date,Date)) as [Day of the Week]
From [Walmart Sales]..WalmartSalesData#csv$

Alter Table dbo.WalmartSalesData#csv$ Add Day_of_Week nvarchar(20);
Update dbo.WalmartSalesData#csv$
Set Day_of_Week = DATENAME(WEEKDAY, convert(date,Date))

--Creating Column Month
Select Date, DATENAME(MONTH, convert(date,Date)) as [Month]
From [Walmart Sales]..WalmartSalesData#csv$

Alter Table dbo.WalmartSalesData#csv$ Add [Month] nvarchar(20);
Update dbo.WalmartSalesData#csv$
Set [Month] = DATENAME(MONTH, convert(date,Date))

--How many unique cities does the data have?
Select count(Distinct(City))
From [Walmart Sales]..WalmartSalesData#csv$

--In which city is each branch?
Select Distinct(City), Branch
From [Walmart Sales]..WalmartSalesData#csv$

--How many unique product lines does the data have?
Select count(Distinct([Product line]))
From [Walmart Sales]..WalmartSalesData#csv$

--What is the most common payment method?
Select distinct(Payment) as [Payment Type], Count(Payment) Over (Partition by Payment) as [Number of Payments]
From [Walmart Sales]..WalmartSalesData#csv$

--What is the most selling product line?
Select Distinct([Product line]), 
Sum(Quantity) OVER (Partition by [Product line]) as [Quantity Sold]
From [Walmart Sales]..WalmartSalesData#csv$

--What is the total revenue by month?
Select [Month], 
Round(Sum(Total),2) as [Revenue] 
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Month]

--What month had the largest COGS?
Select [Month], 
Round(Sum(cogs),2) as [Cost of Goods Sold] 
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Month]

--What product line had the largest revenue?
Select [Product line], 
Round(Sum(Total),2) as Revenue 
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Product line]

--What is the city with the largest revenue?
Select City,
Round(Sum(Total),2) as [Revenue]
From [Walmart Sales]..WalmartSalesData#csv$
Group by City

--What product line had the largest VAT?
Select [Product line], 
Round(avg([Tax 5%]),5) as avg_tax 
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Product line]

--Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
Select [Product line],
Round(AVG(Quantity),4) as [Average Quantity],
(CASE
	When AVG(Quantity) > 5.51 Then 'Good'
	Else 'Bad'
	End) as [Remarks]
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Product line]

--Which branch sold more products than average product sold?
Select Branch, Sum(Quantity) as [Product Sold]
From [Walmart Sales]..WalmartSalesData#csv$
Group by Branch

--What is the most common product line by gender?
Select Gender, [Product line], 
Count(Gender) 
From [Walmart Sales]..WalmartSalesData#csv$
Group by Gender, [Product line]

--What is the average rating of each product line?
Select [Product line], Round(Avg(Rating),3) as [Average Rating]
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Product line]

---------SALES--------------------

--Number of sales made in each time of the day per weekday?
Select Time_of_Day, Count(*) 
From [Walmart Sales]..WalmartSalesData#csv$
Where Day_of_Week = 'Wednesday'
Group by Time_of_Day

--Which of the customer types brings the most revenue?
Select [Customer type],
Round(Sum(Total),2) as [Revenue]
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Customer type]

--Which city has the largest tax percent/ VAT (Value Added Tax)
Select City, Round(AVG([Tax 5%]),4) as VAT
From [Walmart Sales]..WalmartSalesData#csv$
Group by City

--Which customer type pays the most in VAT?
Select [Customer type], Round(avg([Tax 5%]),4) as VAT
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Customer type]

Select *
From [Walmart Sales]..WalmartSalesData#csv$
Where [Invoice ID] = '101-17-6199'
--  ------------Customers------------

--How many unique customer types does the data have?
Select count(Distinct([Customer type]))
From [Walmart Sales]..WalmartSalesData#csv$

--How many unique payment methods does the data have?
Select count(Distinct(Payment))
From [Walmart Sales]..WalmartSalesData#csv$

--What is the most common customer type?
Select [Customer type], count(*)
From [Walmart Sales]..WalmartSalesData#csv$
Group by [Customer type]

--Which customer type buys the most?
Select [Customer type], Count(*)
From [Walmart Sales]..WalmartSalesData#csv$
Where [Customer type] is  Not Null
Group by [Customer type]

--What is the gender of most of the customers?
Select Gender,
Count(*)
From [Walmart Sales]..WalmartSalesData#csv$
Group by Gender

--What is the gender distribution per branch?
Select Branch, Gender,
COUNT(Gender)
From [Walmart Sales]..WalmartSalesData#csv$
Group by Branch, Gender

--Which time of the day do customers give most ratings?
Select Time_of_Day,
Round(Avg(Rating),3) as [Rating by Time of Day]
From [Walmart Sales]..WalmartSalesData#csv$
Group by Time_of_Day

--Which time of the day do customers give most ratings per branch?
Select Time_of_Day, Branch,
Round(Avg(Rating),3) as [Average Rating]
From [Walmart Sales]..WalmartSalesData#csv$
Group by Time_of_Day, Branch
Order by [Average Rating] desc

--Which day fo the week has the best avg ratings?
Select Day_of_Week,
Round(Avg(Rating),3) as [Average Rating]
From [Walmart Sales]..WalmartSalesData#csv$
Group by Day_of_Week
Order by [Average Rating] Desc

--Which day of the week has the best average ratings per branch?
Select Day_of_Week, Branch,
Round(Avg(Rating),3) as [Average Rating]
From [Walmart Sales]..WalmartSalesData#csv$
Group by Day_of_Week, Branch
Order by Branch, [Average Rating] Desc
