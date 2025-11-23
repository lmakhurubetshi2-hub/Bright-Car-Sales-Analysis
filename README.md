# Bright-Car-Sales-Analysis

**A complete SQL workflow for cleaning, transforming, and analysing a full Car Sales dataset.**

---

## 🧮 Project Overview  
This repository contains end-to-end analysis of car sales data using SQL.  
The goal was to clean the dataset, remove duplicates, standardise values, explore sales patterns, and extract meaningful insights around car makes, models, body types, conditions, and states.

---

## 📁 Repository Structure  
- `Project Planning/` — thinking process, scope, objectives, and analysis plan.  
- `Project Description & Raw Data/` — original dataset and field descriptions.  
- `Data Processing & Analysis/` — SQL scripts for cleaning, transformations, exploration, and insights.  
- `Data Presentation/` — charts, summary documents, and visualised results.  
- `README.md` — this file.

---

## 🛠 What I Did  
- Cleaned and standardised text fields (Make, Model, Body, Transmission).  
- Removed duplicate VINs using `ROW_NUMBER() OVER (PARTITION BY VIN)`.  
- Agreed on consistent naming conventions for the entire dataset.  
- Explored key metrics:  
  - Top-selling makes/models  
  - Price comparisons  
  - Distribution by state  
  - Body-type trends  
  - Condition ranges  
- Built clear, easy-to-interpret visualisations from the cleaned dataset.

---

## 🎯 Key Skills & Tools  
- SQL (Snowflake)  
- Data cleaning & transformation  
- Window functions (`ROW_NUMBER`, partitions)  
- Exploratory data analysis  
- Business insight extraction  
- Data visualisation fundamentals






