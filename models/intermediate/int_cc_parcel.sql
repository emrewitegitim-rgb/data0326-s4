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
    pp.qty,
    pp.nb_model  
FROM {{ ref('stg_raw__parcel') }} as p   
JOIN nb_products_parcel as pp
    on p.parcel_id = pp.parcel_id