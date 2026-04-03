select
    p.parcel_id,
    pp.model_mame,
    p.parcel_tracking,
    p.transporter,
    p.priority,
    p.date_purchase,
    p.date_shipping,
    p.date_delivery,
    p.date_cancelled,
    p.month_purchase,
    p.status,
    p.expedition_time,
    p.transport_time,
    p.delivery_time,
    p.delay,
    pp.quantity as qty
FROM {{ ref("int_cc_parcel")}} as p
JOIN {{ ref("stg_raw__parcel_product")}} as pp
    on p.parcel_id = pp.parcel_id
