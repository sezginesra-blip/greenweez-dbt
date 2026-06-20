SELECT
    -- Tarihi AY kırılımına getirmek için BigQuery'nin DATE_TRUNC fonksiyonunu kullanıyoruz
    DATE_TRUNC(date_date, MONTH) AS datemonth,
    
    -- Kâr ve Maliyet Metriklerinin Toplamı
    SUM(ads_margin) AS ads_margin,
    SUM(operational_margin) AS operational_margin, -- Zaten kârı bu sütun temsil ediyor
    
    -- Ortalama Sepet Değerinin Ay Bazında Doğru Hesaplanması
    SUM(revenue) / SUM(nb_transactions) AS average_basket,
    
    -- Reklam Metriklerinin Toplamı
    SUM(ads_cost) AS ads_cost,
    SUM(ads_impression) AS ads_impression,
    SUM(ads_clicks) AS ads_clicks,
    
    -- Operasyonel ve Satış Metriklerinin Toplamı
    SUM(quantity) AS quantity,
    SUM(revenue) AS revenue,
    SUM(purchase_cost) AS purchase_cost,
    SUM(shipping_fee) AS shipping_fee,
    SUM(log_cost) AS log_cost
   
FROM {{ ref('finance_campaigns_day') }}
GROUP BY DATE_TRUNC(date_date, MONTH)
ORDER BY datemonth DESC