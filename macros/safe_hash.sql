{% macro safe_hash(columns) %}
    {% set coalesced_columns = [] %}
    {% for column in columns %}
        {% do coalesced_columns.append("COALESCE(LOWER(" ~ column ~ "), '')") %}
    {% endfor %}
    MD5({{ coalesced_columns | join(' || ') }})
{% endmacro %}
