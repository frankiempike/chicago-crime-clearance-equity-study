CREATE OR REPLACE TABLE `chicago_justice.community_summaries` AS
SELECT Community_Area,
  SUM(_25_000_to__49_999)/(SUM(_25_000_to__49_999) + SUM(_50_000_to__74_999) + SUM(_75_000_to__125_000) + SUM(_125_000__)) AS percent_less_than_50k,
  SUM(_50_000_to__74_999)/(SUM(_25_000_to__49_999) + SUM(_50_000_to__74_999) + SUM(_75_000_to__125_000) + SUM(_125_000__)) AS percent_50_75k,
  SUM(_75_000_to__125_000)/(SUM(_25_000_to__49_999) + SUM(_50_000_to__74_999) + SUM(_75_000_to__125_000) + SUM(_125_000__)) AS percent_75_125k,
  SUM(_125_000__)/(SUM(_25_000_to__49_999) + SUM(_50_000_to__74_999) + SUM(_75_000_to__125_000) + SUM(_125_000__)) AS percent_125k_up,
  SUM(Total_Population) AS total_pop,
  SUM(White_Not_Hispanic_or_Latino)/SUM(Total_Population) AS percent_white, 
  SUM(Hispanic_or_Latino)/SUM(Total_Population) AS percent_latine, 
  SUM(Black_or_African_American)/SUM(Total_Population) AS percent_black, 
  SUM(American_Indian_or_Alaska_Native)/SUM(Total_Population) AS percent_native, 
  SUM(Asian)/SUM(Total_Population) AS percent_asian, 
  SUM(Native_Hawaiian_or_Pacific_Islander)/SUM(Total_Population) AS percent_hawaiian, 
  SUM(Other_Race)/SUM(Total_Population) AS percent_other, 
  SUM(Multiracial)/SUM(Total_Population) AS percent_multiracial, 
 FROM `chicago-justice-analysis.chicago_justice.socioeconomic_lookup`
 GROUP BY Community_Area;