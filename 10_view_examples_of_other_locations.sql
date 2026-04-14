SELECT location_description,
  COUNT(*) AS crimes
FROM chicago_justice.crime_analysis_by_community
WHERE location_type = 'Other'
GROUP BY location_description
ORDER BY crimes DESC;