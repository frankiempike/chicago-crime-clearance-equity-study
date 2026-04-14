[![SQL Linting](https://github.com/frankiempike/chicago-crime-clearance-equity-study/actions/workflows/lint.yml/badge.svg)](https://github.com/frankiempike/chicago-crime-clearance-equity-study/actions/workflows/lint.yml)
# Analysis of Chicago Crime Clearance Rates Across Communities, Socioeconomic Factors, and Types of Crimes (2020–2026)

## Project Overview
This project investigates the relationship between community income and crime "clearance rates" (arrests) across Chicago's 77 community areas. By joining live crime data from the Chicago Data Portal with ACS 5-Year Data by Community Area, this analysis identifies where "justice gaps" exist based on socioeconomic factors and where the crime occurred.

## Key Insights & Features
* **Digital Crime Classification:** Identified a critical gap where traditional reporting misclassifies digital fraud as 'Other' or 'Unknown' locations. I engineered pattern-matching logic to correctly categorize **11,257** incidents as **Online**. 
* **The Clearance Gap:** My analysis revealed that Online crimes have a near-zero arrest rate of **0.16%**, representing an **18.15% lower** clearance rate than crimes occurring in public spaces (18.31%).
* **Modern Socioeconomic Benchmarking:** Utilized the 2023 ACS 5-Year Estimates to ensure income and poverty metrics are representative of the current post-2020 period.
* **Official Geo-Relational Mapping:** Leveraged the Chicago Data Portal’s official boundary metadata to create a high-integrity link between Crime IDs and Community Area names, avoiding the inaccuracies of manual "fuzzy" matching.

## The Data Stack
* **Google BigQuery (SQL):** Data warehousing, ETL, and analytical querying.
* **Looker Studio:** Data visualization and dashboarding.

## Repository Structure
The analysis is organized into a sequential pipeline:
1. `01_ingest_chicago_crime_data.sql`: Initial ingestion, filtering, and primary categorization.
2. `02_summarize_socioeconomic_lookup.sql`: Preparation of census-based community indicators.
3. `03_join_community_IDs_to_summaries.sql`: Creating the master relational link between datasets.
4. `04_analyze_unsolved_rate_by_crime_type.sql`: Baseline clearance analysis by offense.
5. `05_analyze_unsolved_rate_by_crime_location.sql`: Comparing clearance across physical and digital spaces.
6. `06_analyze_unsolved_rate_by_community_low_income_rate.sql`: Analyzing the "Justice Gap" across poverty tiers.
7. `07_analyze_unsolved_by_community_wealth_and_offense_type.sql`: Intersectional analysis of wealth and crime severity.
8. `08_analyze_violent_crimes_by_location.sql`: Targeted look at violent crime clearance in specific areas.
9. `09_analyze_violent_crimes_by_wealth_and_location.sql`: Targeted look at violent crime clearance in specific contexts.
10. `10_view_examples_of_other_locations.sql`: Data validation and discovery for "unclassified" location descriptions.
* `data_samples/`: Small CSV exports of the final transformed dataset for preview.

## How to Reproduce
This pipeline is designed in two phases: **Data Engineering** (Scripts 01-03) and **Analysis** (Scripts 04-10).

### Option A: Full Pipeline Reproduction
If you wish to rebuild the entire master table from scratch:
1.  **Crime Data:** Access `bigquery-public-data.chicago_crime.crime`.
2.  **Boundary Mapping:** Download the [Boundaries - Community Areas](https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Community-Areas-Map/cauq-8yn6) dataset and upload as `community_ids`.
3.  **Socioeconomic Data:** Download the [2023 ACS 5-Year Data](https://data.cityofchicago.org/Community-Economic-Development/ACS-5-Year-Data-by-Community-Area/t68z-cikk/about_data) and upload as `community_summaries`.
4.  Execute scripts `01` through `03` to generate the master table.

### Option B: Quick Analysis (Start Here)
If you want to skip the data engineering and jump straight to the insights, use the provided sample:
1.  Navigate to `/data_samples/crime_analysis_sample.csv`.
2.  This file is a pre-cleaned, pre-joined sample of the final master table.
3.  Upload this CSV to BigQuery as `crime_analysis_by_community`.
4.  **Run scripts 04 through 10** to see the analysis logic in action.

---
