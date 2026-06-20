SELECT
    date_date,
    paid_source,
    campaign_key,
    campaign_name,
    SUM(CAST(ads_cost AS FLOAT64)) as total_cost, 
    SUM(impression) as total_impressions,
    SUM(click) as total_clicks
FROM {{ ref('int_campaigns') }} 
GROUP BY date_date, paid_source, campaign_key, campaign_name
ORDER BY date_date DESC 