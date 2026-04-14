CREATE OR REPLACE TABLE `chicago_justice.crime_analysis_by_community` AS
SELECT
    c.*,
    s.* EXCEPT (community_area)
FROM `chicago_justice.crime_data` AS c
INNER JOIN `chicago_justice.community_IDs` AS ids
    ON c.community_area = ids.area_numbe
INNER JOIN `chicago_justice.community_summaries` AS s
    ON ids.community = s.community_area
ORDER BY c.date, c.community_area;
