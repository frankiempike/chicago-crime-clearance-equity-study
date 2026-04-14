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
8. `08_analyze_violent_crimes_by_wealth_and_location.sql`: Targeted look at violent crime clearance in specific contexts.
9. `09_view_examples_of_other_locations.sql`: Data validation and discovery for "unclassified" location descriptions.
* `data_samples/`: Small CSV exports of the final transformed dataset for preview.

## How to Reproduce
This pipeline relies on three primary data sources from the Chicago Data Portal. To replicate the results, follow these steps:
1.  **Crime Data:** Access the `bigquery-public-data.chicago_crime.crime` table in the BigQuery console.
2.  **Boundary Mapping:** Download the [Boundaries - Community Areas](https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Community-Areas-Map/cauq-8yn6) dataset. Upload this to BigQuery as `community_ids`.
3.  **Socioeconomic Data:** Download the [ACS 5-Year Data by Community Area](https://data.cityofchicago.org/Community-Economic-Development/ACS-5-Year-Data-by-Community-Area/t68z-cikk/about_data) (2023 release). Upload this to BigQuery as `community_summaries`.
4.  **Execute Pipeline:** Run the scripts in the `/sql_scripts` folder in numerical order (01–09). These scripts handle data cleaning, the classification logic for digital crimes, and the final enrichment joins.

---
