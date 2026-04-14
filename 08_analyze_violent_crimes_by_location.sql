SELECT 
    location_type,
    COUNT(*) AS total_crimes,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage_of_total_violent,
    ROUND((COUNT(*) - SUM(CASE WHEN arrest THEN 1 ELSE 0 END)) / COUNT(*) * 100.0, 2) AS unsolved_percentage
FROM `chicago_justice.crime_analysis_by_community`
WHERE offense_category = 'Violent/Safety'
GROUP BY location_type
ORDER BY unsolved_percentage DESC;