SELECT
    primary_type,
    COUNT(*) AS total_incidents,
    ROUND(100 - (AVG(CASE WHEN arrest THEN 1 ELSE 0 END) * 100), 2)
        AS unsolved_percentage
FROM `chicago_justice.crime_analysis_by_community`
GROUP BY primary_type
HAVING COUNT(*) > 10
ORDER BY unsolved_percentage DESC;
