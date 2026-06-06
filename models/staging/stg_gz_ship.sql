with source as (
    select * from {{ source('raw', 'ship') }}
),

renamed as (
    select
        orders_id,
        shipping_fee,
        CAST(ship_cost as FLOAT64) as ship_cost,
        logCost as log_cost,
        
    from source
)

select * from renamed