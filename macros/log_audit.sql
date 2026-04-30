-- macros/audit_log.sql

{% macro log_audit(model_name, layer) %}

    {% set query %}
        insert into DBT_DEV.AUDIT.DBT_AUDIT_LOG
        (
            RUN_ID,
            MODEL_NAME,
            LAYER,
            ROW_COUNT,
            STATUS,
            START_TIME,
            END_TIME,
            EXECUTION_TIME
        )
        select
            '{{ invocation_id }}',
            '{{ model_name }}',
            '{{ layer }}',
            count(*),
            'SUCCESS',
            current_timestamp(),
            current_timestamp(),
            0
        from {{ this }}

    {% endset %}

    {% do run_query(query) %}

{% endmacro %}