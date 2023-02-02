
with
    source as (select * from {{ source("raw", "opportunity_header") }}),

    staged as (select * from source)

select *
from staged
