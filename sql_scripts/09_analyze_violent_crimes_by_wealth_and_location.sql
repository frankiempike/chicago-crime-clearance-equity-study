WITH CategoryMetrics AS (
    SELECT 
        CASE 
            WHEN percent_less_than_50k <= 0.10 THEN '0-10%'
            WHEN percent_less_than_50k <= 0.20 THEN '11-20%'
            WHEN percent_less_than_50k <= 0.30 THEN '21-30%'
            WHEN percent_less_than_50k <= 0.40 THEN '31-40%'
            WHEN percent_less_than_50k <= 0.50 THEN '41-50%'
            ELSE 'Over 50%'
        END AS percent_of_community_making_less_than_50k,
        location_type,
        COUNT(*) AS total_crimes,
        ROUND((COUNT(*) - SUM(CASE WHEN arrest THEN 1 ELSE 0 END)) / COUNT(*) * 100, 2) AS unsolved_percentage
    FROM `chicago_justice.crime_analysis_by_community`
    WHERE offense_category = 'Violent/Safety'
    GROUP BY percent_of_community_making_less_than_50k, location_type
),
RankedMetrics AS (
    SELECT 
        *,
        RANK() OVER(PARTITION BY percent_of_community_making_less_than_50k ORDER BY total_crimes DESC) as volume_rank,
        RANK() OVER(PARTITION BY percent_of_community_making_less_than_50k ORDER BY unsolved_percentage DESC) as unsolved_rank
    FROM CategoryMetrics
)
SELECT 
    percent_of_community_making_less_than_50k,
    location_type,
    total_crimes,
    unsolved_percentage,
    CASE 
        WHEN volume_rank <= 2 AND unsolved_rank <= 2 THEN 'Top Volume & Top Unsolved'
        WHEN volume_rank <= 2 THEN 'Top Volume'
        WHEN unsolved_rank <= 2 THEN 'Top Unsolved'
    END as insight_label
FROM RankedMetrics
WHERE volume_rank <= 2 OR unsolved_rank <= 2
ORDER BY unsolved_percentage DESC;