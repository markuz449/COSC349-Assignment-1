{{ content() }}
<div class="row jumbo">
    <div class="container">
        <div class="column" >
            <h1>Chains</h1>
        </div>
    </div>
</div>
    {% for chain in chains %}
    <div class="row mt-2">
        <div class="container">
			<div class="five columns">
				<h2>{{ chain.name }}</h2>
				<p>
                {{ partial('partials/rating', ['rating': chain.rating]) }}
                ({{ chain.reviews|length }})
				</p>
				<p>{{ link_to('chains/' ~ chain.nicename, 'See Reviews', 'class':'button') }}</p>
			</div>
			<div class="seven columns">
				<table class="u-full-width">
					<tr>
						<th>Price</th>
						<th>Number</th>
						<th>Per Nugget</th>
					</tr>
					{% for price in chain.prices %}
					<tr>
						<td>{{ price.price|money }}</td>
						<td>{{ price.number }}</td>
						<td>{{ price.per|money }}</td>
					</tr>
					{% endfor %}
				</table>
			</div>
		</div>
	</div>
{% endfor %}
