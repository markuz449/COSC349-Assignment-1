<div class="row">
<div class="container">
{{ content() }}
<div class="twelve columns">
<table class="u-full-width">
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Date</th>
    </tr>
{% for message in messages %}
<a href="">
    <tr {% if !message.read %}class="unread"{% endif %}>
        <td>{{ link_to('messages/read/' ~ message.id, message.name) }}</td>
        <td>{{ message.email }}</td>
        <td>{{ message.datetime }}</td>
    </tr>
</a>
{% endfor %}
</table>
</div>
</div>
</div>

<style>
.unread {
font-weight: bold;
}
