{{ config(
            materialized='incremental',
            schema="pre_transformed"
        )
}}

select *  FROM {{source('PostgreSQL','sales_trans')}}
{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
     where current_timestamp > (select max(TRANS_TIMESTAMP) from {{ this }})
{% endif %}
