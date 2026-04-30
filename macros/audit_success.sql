{% macro audit_success(model_name) %}

    update DBT_DEV.AUDIT.DBT_AUDIT_LOG
    set 
        STATUS = 'SUCCESS',
        END_TIME = current_timestamp(),
        ROW_COUNT = (select count(*) from {{ this }})
    where 
        BATCH_ID = '{{ invocation_id }}'
        and MODEL_NAME = '{{ model_name }}';

{% endmacro %}