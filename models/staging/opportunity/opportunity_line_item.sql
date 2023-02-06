
with
    source as (select * from {{ source("raw", "opportunity_line_item") }}),

    staged as (select * from source)

select *
from staged
order by id
