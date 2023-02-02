{{ config(
            materialized='incremental'
        )
}}

select S1.PRODUCT_ID,P1.PRODUCT_NAME,S1.QTY,(S1.QTY * P1.UNIT_PRICE) AS TOTAL_SALES,S1.TRANS_TIMESTAMP 
    FROM {{source('PostgreSQL','sales_trans')}} as S1 INNER JOIN {{source('PostgreSQL','product')}} AS P1
    ON S1.PRODUCT_ID=P1.PRODUCT_ID
{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
     where S1.TRANS_TIMESTAMP > (select max(S1.TRANS_TIMESTAMP) from {{ this }})
{% endif %}
