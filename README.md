# 📚 Library Management System – Data Analytics Dashboard

Tools: MS SQL Server | Power BI | DAX | T-SQL

Domain: Data Analytics | Business Intelligence

🧾 Project Description

This project is a complete Library Management System that integrates a structured SQL database with a Power BI dashboard to deliver real-time, data-driven insights. It simulates how a library tracks book circulation, manages overdue returns, monitors employee performance, and analyzes member engagement.

Using MS SQL Server, I created a fully normalized database and built complex queries for operations and reporting. The data was then visualized in Power BI through an interactive dashboard, offering a 360-degree view of library activities.

🎯 Objectives

Design a relational database to store and manage library data efficiently.

Analyze member behavior, book usage trends, and overdue penalties using SQL queries.

Create a professional dashboard that helps stakeholders make informed decisions.

Implement automation using stored procedures for seamless backend operations.

🗂️ Key Features

🔸 Database Design (SQL Server)

Created 6+ normalized tables (books, members, employees, branch, issued_status, return_status)

Defined primary and foreign keys to enforce referential integrity

Used ALTER statements to manage data types and constraints

Designed and executed CRUD operations (Insert, Update, Delete, Select)

🔸 Data Analysis (T-SQL)

Identified:

📌 Books not returned or overdue

📌 Members who never borrowed a book

📌 Employees with most issued books

📌 Branches with highest circulation

📌 Average return time by book category

📌 Fine collection based on overdue duration

Used Joins, Aggregations, Group By, Having, and Date functions

🔸 Power BI Dashboard

Built two interactive pages with filters/slicers by category, branch, date, and member

Visualizations include:

KPI cards (Total Books, Members, Employees, Returned Books, etc.)

Bar charts (Issued Books by Category, Overdue by Member, Top Members)

Line and Area charts (Monthly Trends, Registrations, Employee Activity)

Pie chart for Book Availability

Used DAX Measures for calculating metrics like overdue counts and utilization %

🔸 Automation

Developed a Stored Procedure to auto-update book status on return

Applied CTAS (Create Table As Select) to generate summary tables (e.g., Book Issue Count)

📊 Dashboard Preview

📌 Overview Page

📌 Detailed Analysis Page

🛠️ Tools & Technologies

Database	MS SQL Server

BI Tool	Microsoft Power BI

Languages	SQL, T-SQL, DAX

Visuals	Bar, Line, Pie, Area, Cards

Features Used	Slicers, Measures, Filters, Joins, Stored Procedures

💼 Business Recommendations

Improve Book Acquisition Strategy: 
Focus on high-demand categories (e.g., Fiction, Classic) based on usage trends to optimize future purchases.

Enforce Overdue Policies:
Strengthen follow-ups for overdue returns and implement automated notifications to reduce fines and resource unavailability.

Engage Inactive Members:
Identify and reach out to members who haven’t borrowed any books to increase engagement and membership value.

Reward Productive Employees & Branches:
Recognize top-performing staff and high-circulation branches to motivate consistent performance.

Optimize Inventory:
Reduce investment in underutilized categories and reallocate budget to more frequently issued books.

Track and Improve Return Timeliness:
Monitor average return time by category and adjust return periods or fine structures accordingly

📘 Learning Outcomes

Deepened my knowledge of data modeling, data cleaning, and visual storytelling

Strengthened proficiency in writing complex SQL queries and designing BI dashboards

Learned how to build analytical systems that simulate real-world business scenarios

Applied DAX for calculating KPIs, return delays, and book utilization rates

