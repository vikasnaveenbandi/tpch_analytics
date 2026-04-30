{% macro log_run_results(results) %}

{% for res in results %}
    {% if res.status != 'success' %}

        update DBT_DEV.AUDIT.DBT_AUDIT_LOG
        set 
            STATUS = 'FAILED',
            END_TIME = current_timestamp(),
            ERROR_MESSAGE = '{{ res.message }}'
        where 
            BATCH_ID = '{{ invocation_id }}'
            and MODEL_NAME = '{{ res.node.name }}';

    {% endif %}
{% endfor %}

{% endmacro %}