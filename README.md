## 2. README for **Bright-Car-Sales-Analysis**

```markdown
# Bright-Car-Sales-Analysis

**This repository contains a complete SQL workflow for exploring, cleaning, and analysing the Car Sales dataset.**  

---

## 📊 Project Overview  
In this project I worked with a car sales dataset to perform an end-to-end analytics workflow: data ingestion, cleaning, transformation, analysis, and presentation of findings. The main objective was to answer key business questions around which car makes/models are selling, trends in body type, condition, geography, etc.

---

## 📁 Repository Structure  
- `Project Planning/` — documentation of planning, objectives, questions to answer.  
- `Project Description & Raw Data/` — dataset files, metadata, description of fields.  
- `Data Processing & Analysis/` — SQL scripts (e.g., Snowflake SQL).  
- `Data Presentation/` — output reports, charts, summary tables.  
- `README.md` — this file.

---

## 🛠 Workflow & Methodology  
1. **Data ingestion**: Loaded raw dataset into SQL environment.  
2. **Data cleaning**: Standardised text fields (make, model, body), handled missing values, removed duplicates.  
3. **Analysis**:  
   - Aggregated unit counts by make/model/trim, by geography, by condition.  
   - Calculated min/max/average sale price by model or body type.  
   - Identified trends over time.  
4. **Presentation**: Generated summary tables and visualisations (charts) to show key findings, e.g., top selling models, price distribution, regional differences.  
5. **Insights**: Derived business-relevant observations such as which segments are under-/over-performing, how condition affects price, where inventory may need adjustment.

---

## 🔍 Key Business Questions Addressed  
- Which car makes and models have the highest volume of sales?  
- What is the price distribution by condition (used vs new, etc)?  
- How does body type (SUV, sedan, etc) influence sales and pricing?  
- Are there regional patterns in sales volumes and pricing?  
- What data-quality issues exist (duplicate VINs, missing fields) and how were they addressed?

---

## 📚 Skills & Tools  
- SQL (Snowflake dialect in this case)  
- Data cleaning and standardisation  
- Descriptive analytics and summarisation  
- Data visualisation for business insights  
- Structuring an analytics workflow from planning to presentation



