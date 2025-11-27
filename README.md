Croma Database Model

This repository contains the database model designed for Croma, a comprehensive retail company database system. 
The model was created through reverse engineering and includes a detailed schema covering key business entities such as Catalogue, Brands, Categories, Products, Inventory, Purchases, Vendors, Supply Chain, Stores, Employees, Customers, Orders, Sales, and Service Requests. 
The database schema supports operations management, logistics tracking, customer relationship management, and transactional sales processes.
The tables have been populated with dummy data to simulate real-world scenarios and to facilitate testing and development. 
An accompanying SQL script is provided to create the schema and populate the tables with this sample data. 

Features
Core Entities: Products, Brands, Categories, Customers, Stores, Employees, Vendors.

Transactions: Orders, Sales, Purchases, Inventory movements, Service requests.

Relationships: Junction tables for many-to-many links (e.g., Inventory-Purchases, Stores-Customers).

Key Fields: Stock quantities, transaction amounts, customer loyalty points, supply dates, employee assignments.​

Constraints: ENUMs for status/availability, indexes for performance on IDs and dates
