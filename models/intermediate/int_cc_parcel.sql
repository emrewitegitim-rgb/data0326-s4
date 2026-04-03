with nb_products_parcel as (
    select
        parcel_id,
        count(model_mame) as nb_model,
        sum(quantity) as qty
    FROM {{ ref('stg_raw__parcel_product') }}
    GROUP BY parcel_id
)

select
    p.*,
    EXTRACT(MONTH FROM date_purchase) as month_purchase,
    CASE
        WHEN date_cancelled IS NOT NULL THEN 'Cancelled'
        WHEN date_shipping IS NULL THEN 'In progress'
        WHEN date_delivery IS NULL THEN 'Shipped'
        WHEN date_delivery IS NOT NULL THEN 'Delivered'
        ELSE NULL
    END as status,
    DATE_DIFF(date_shipping, date_purchase, DAY) as expedition_time,
    DATE_DIFF(date_delivery, date_shipping, DAY) as transport_time,
    DATE_DIFF(date_delivery, date_purchase, DAY) as delivery_time,
    IF(DATE_DIFF(date_delivery, date_purchase, DAY)>4, DATE_DIFF(date_delivery, date_purchase, DAY) - 4, NULL) as delay,
    pp.qty,
    pp.nb_model  
FROM {{ ref('stg_raw__parcel') }} as p   
JOIN nb_products_parcel as pp
    on p.parcel_id = pp.parcel_id