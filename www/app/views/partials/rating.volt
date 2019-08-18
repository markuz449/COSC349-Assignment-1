{% if rating > 0 %}
<span class="star">
    {% for _ in 1..rating %}
&#x2605;
    {% endfor %}
</span>
    {% if rating < 5 %}
<span class="star-empty">
        {% for _ in rating..4 %}
&#x2605;
        {% endfor %}
</span>
    {% endif %}
{% else %}
<span class="star">
&#x2605;
&#x2605;
&#x2605;
&#x2605;
&#x2605;
</span>
{% endif %}
