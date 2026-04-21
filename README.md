# Mexico-Toy-Sales---Regional-Inventory-Analysis
<img width="871" height="493" alt="executive dashboard" src="https://github.com/user-attachments/assets/3bdb72be-e074-4e47-b072-5b536fc59064" />

Executive dashboard showing regional sales with overall Revenue, Profit and Profit Margin.

End-To-End retail sales analytics project utilizing MySQL for ETL and Power BI for executive dashboard. Highlights include importing 500K+ rows of data using LOAD DATA INFILE query in MySQL and resolving granularity error by data modeling in Power BI.

# Project Overview
This project transforms 829262 rows of data into 3-Tier Executive Summary, covering overall data lifecycle from optimizing SQL ingestion to overall Power BI modelling and overall performance visualization.
[click here to download the data](https://www.kaggle.com/datasets/amulyas/mexican-toys-sales) 

# The challenges
* SQL Ingestion - Importing csv file consisting 5000+K rows using LOAD DATA INFILE query instead of utilizing wizard import which was the reason for missing 350+K rows of data.
* Standardization - Removing currrency symbol and converting text to decimal from mathematical calculation without interrupting SAFETY UPDATE mode.
* Granularity Reconciliation - Reconstructing data relationship and applying aggregated DAX functions to prevent row-duplication and validating calculation that matches the business reality.

# Technical Implementation
* Phase 1 : Data Engineering in MySQL
  - Data Ingestion - Utilized LOAD DATA INFILE method to overcome standard import limit and handling data efficiency.
  - Data Transformation - Converted currecy into decimals by removing currency symbol using replace function and converting data type into decimals.
  - Semantic Layer - Created 'master_sales_analytics' view to encapsulate business logics at the database level, which can be used further for visualization.
* Phase 2 : Business Intelligence in Power BI
  - Data Modelling - Imported the table created in previous phase and creating calender table using DAX function and constructing relationship between them, mapping many to one function.
  - Visualization - Performed 3-tier overall visualization each page describes about different business performance analysis.
     - Regional Analysis - Mapped revenue concentration cross Mexico cities and finding revenue and profit across cities and stores gained from each products.
     - Trend Analysis - Analysed monthly sales for over a period and forecasting future 3 month sales, ranking the products sold across the time.
     - Inventory Analysis - Correlated stock availability with inventory velocity with revenue lost to figure out the supply chain gap based on products and cities.

# Key Highlights
* Primary Hub - Among all Mexico cities, Cuidad de mexico is maintaining consistent profit irrespective of categories.
* Profit Leader - The Toys category represents the largest share of net profit, despite high inventory requirement.
* Inventory loss - Identified specific regions where stock level were high and revenue is lost, suggested a better stock redistribution.

# Project Structure
* SQL_script contains the full ETL pipeline and view creation.
* mexico_toysales contains dashboard file featuring overall performance analysis.
* documentation contains PDF export of dashborard for quick view.
