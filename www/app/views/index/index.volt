<div class="row jumbo">
    <div class="container">
        <div class="twelve columns">
            <div class="jumbo-text">
            <h1>Nugget Watch</h1>
            <p class="sub-text">{{ herotext }}</p>
            </div>
            <img src="/img/nug.png">
        </div>
    </div>
</div>

<div class="row mt-2 mb-2">
    <div class="container">
        <div class="column">
            {{ content() }}
            <h2>About Nugget Watch</h2>
            <p>Nugget Watch keeps track of chicken nugget prices in New Zealand and presents you the best deals, when you want them.  Are you looking for reviews before deciding which nuggets to get? We got those too!
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

<style>
.jumbo {
    background-color: #ffb14d;
    color: white;
    line-height: 0;
    z-index: 0;
    padding: 0;
    display: block;
}
.jumbo-text {
    font-size: 2.4vw;
    padding: 4em 0;
}
.jumbo h1 {
    text-transform: uppercase;
    font-size: 5em;
    margin-bottom: 0;
}
.jumbo p {
    line-height: 1.6;
    font-size: 1.5em;
    font-family: 'Fjalla One', sans-serif;
    padding: 0;
    margin: 0;
}
.jumbo img {
    float: right;
    margin-top: -38.9%;
    max-width: 41%;
    margin-right: -8%;
}
.navBar a.title {
    background-color: #FFB14D;
}
@media only screen and (min-width: 1030px) {
    .jumbo-text {
        font-size: 2.5rem;
        padding: 4em 0;
    }
		.jumbo img {
		margin-top: -35.7%;
		max-width: 37.8%;
		margin-right: 0;
		float: right;
	}
}
{#
.jumbo .container, .jumbo .columns {
    height: 100%;
}
.jumbo-text {
    width: 100%;
    position: absolute;
    left: 0;
    text-align: center;
    font-size: 1.2rem;
    padding: 8em 0 5em;
    z-index: 2;
}
.jumbo h1 {
    text-transform: uppercase;
    letter-spacing: 0.03em;
    font-size: 10em;
}
.sub-text {
    font-size: 2.6em;
    font-family: 'Fjalla One', sans-serif;
}
.jumbo img {
    max-height: 74%;
    position: absolute;
    right: -3em;
    bottom: 0;
    z-index: 1;
}
#}
</style>
