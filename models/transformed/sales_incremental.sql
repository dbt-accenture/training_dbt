{{ config(
            materialized='incremental',
            schema  =   'enhanced'
        )
}}

select *  FROM {{source('PostgreSQL','sales_trans')}}
{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
     where S1.TRANS_TIMESTAMP > (select max(S1.TRANS_TIMESTAMP) from {{ this }})
{% endif %}
