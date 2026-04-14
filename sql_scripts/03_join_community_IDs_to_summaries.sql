CREATE OR REPLACE TABLE `chicago_justice.crime_analysis_by_community` AS
SELECT 
    c.*,
    s.* EXCEPT (Community_Area)
FROM `chicago_justice.crime_data` AS c
JOIN `chicago_justice.community_IDs` AS ids
    ON c.community_area = ids.area_numbe
JOIN `chicago_justice.community_summaries` AS s
    ON ids.COMMUNITY = s.Community_Area
ORDER BY c.date, c.community_area;
