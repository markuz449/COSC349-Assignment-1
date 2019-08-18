<div class="container">
<div class="row mt-2">
<h1>Prices</h1>
{{ flashSession.output() }}
{{ content() }}
<form action="" target="_self" method="post">
  <div class="row">
    <div class="four columns">
      <label for="price">Price</label>
      <input class="u-full-width" type="number" step="0.01" placeholder="$10" id="price" name="price">
    </div>
    <div class="four columns">
      <label for="number">Number</label>
      <input class="u-full-width" type="number" placeholder="12" id="number" name="number">
    </div>
    <div class="four columns">
      <label for="Chain">Chain</label>
		<select id="chain" name="chain" class="u-full-width">
			<option selected="selected" disabled="disabled">Chain</option>
			<option value="1">Burger King</option>
			<option value="2">KFC</option>
			<option value="3">McDonald's</option>
			<option value="4">Wendy's</option>
		</select>
    </div>
  </div>
  <input class="button" type="submit" value="Submit">
</div>
</form>
	{% for chain in chains %}
    <div class="row">
        <h2><a name="{{ chain.nicename }}"></a>{{ chain.name }}</h2>
        <table class="u-full-width">
        <thead>
            <tr>
                <th>Price</th>
                <th>#</th>
                <th>Per</th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        {% for price in chain.prices %}
            <tr>
            <td>{{ price.price|money }}</td>
            <td>{{ price.number }}</td>
            <td>{{ price.per|money }}</td>
            <td>{{ price.checked|diffForHumans }}</td>
            <td>{{ link_to('prices/delete/' ~ price.id, "Delete") }}</td>
            <td>{{ link_to('prices/confirm/' ~ price.id, "Confirm") }}</td>
            </tr>
        {% endfor %}
        </tbody>
        </table>
     </div>
     {% endfor %}
</div>
</div>
