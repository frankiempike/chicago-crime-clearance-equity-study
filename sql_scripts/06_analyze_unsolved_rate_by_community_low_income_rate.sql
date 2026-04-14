SELECT 
    CASE 
        WHEN percent_less_than_50k <= 0.10 THEN '0-10%'
        WHEN percent_less_than_50k <= 0.20 THEN '11-20%'
        WHEN percent_less_than_50k <= 0.30 THEN '21-30%'
        WHEN percent_less_than_50k <= 0.40 THEN '31-40%'
        WHEN percent_less_than_50k <= 0.50 THEN '41-50%'
        ELSE 'Over 50%'
    END AS percent_of_community_making_less_than_50k,
    COUNT(*) AS total_crimes,
    SUM(total_pop) AS population,
    ROUND(
        (COUNT(*) - SUM(CASE WHEN arrest THEN 1 ELSE 0 END)) / COUNT(*) * 100, 
        2
    ) AS unsolved_percentage,
    SUM(CASE WHEN arrest THEN 1 ELSE 0 END) AS total_arrests,
    ROUND((SUM(CASE WHEN arrest THEN 1 ELSE 0 END) / SUM(total_pop))*100, 5) AS arrests_per_pop
    
FROM `chicago_justice.crime_analysis_by_community`
GROUP BY percent_of_community_making_less_than_50k
ORDER BY arrests_per_pop DESC;