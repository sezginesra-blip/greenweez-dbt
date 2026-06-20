with finance_days as (
    select * from {{ ref('finance_days') }}
),

campaigns_day as (
    -- int_campaings_day modelindeki metrikleri gün bazında topluyoruz
    select
        date_date,
        sum(total_cost) as ads_cost,
        sum(total_impressions) as ads_impression,
        sum(total_clicks) as ads_clicks
    from {{ ref('int_campaings_day') }}
    group by date_date
)

select
    f.date_date,
    -- İstenen formül: ads_margin hesaplaması
    (f.operational_margin - coalesce(c.ads_cost, 0)) as ads_margin,
    f.nb_transactions,
    f.revenue,
    f.average_basket,
    f.operational_margin,
    f.purchase_cost,
    f.shipping_fee,
    f.log_cost,
    f.quantity,
    coalesce(c.ads_cost, 0) as ads_cost,
    coalesce(c.ads_impression, 0) as ads_impression,
    coalesce(c.ads_clicks, 0) as ads_clicks
from finance_days f
left join campaigns_day c 
    on f.date_date = c.date_date -- İşte aradığın birleştirme parametresi!
order by f.date_date desc