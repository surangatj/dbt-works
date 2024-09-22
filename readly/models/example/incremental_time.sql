{{config(materialized='incremental', unique_key = 't_time')}}

SELECT
    *
FROM
    SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.TIME_DIM
WHERE
    to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND))<=current_time()


    {% if is_incremental() %}
       and to_time(CONCAT(T_HOUR,':', T_MINUTE,':', T_SECOND)) > (select max(to_time(CONCAT(T_HOUR,':', T_MINUTE,':', T_SECOND)))
       from {{ this }})
    {% endif %}
