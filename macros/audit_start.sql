{% macro audit_start(model_name, layer) %}

    insert into DBT_DEV.AUDIT.DBT_AUDIT_LOG
    (
        BATCH_ID,
        MODEL_NAME,
        LAYER,
        STATUS,
        START_TIME
    )
    values
    (
        '{{ invocation_id }}',
        '{{ model_name }}',
        '{{ layer }}',
        'STARTED',
        current_timestamp()
    );

{% endmacro %}