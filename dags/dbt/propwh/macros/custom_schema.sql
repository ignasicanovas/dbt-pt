{% macro generate_schema_name(custom_schema_name, node) %}
    {% if custom_schema_name == 'staging' %}
        {{ 'staging' }}
    {% elif custom_schema_name == 'corporate' %}
        {{ 'corporate' }}
    {% elif target.name == 'prod' %}
        {{ "dtm_" ~ var('nation_name', 'default') | lower }}
    {% else %}
        {{ "dtm_" ~ var('nation_name', 'default') | lower }}
    {% endif %}
{% endmacro %}
