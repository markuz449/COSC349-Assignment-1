<div class="container mt-2 mb-2">
	<div class="row">
        {{ flashSession.output() }}
		<h1>Stats</h1>
		{{ content() }}
	</div>
	<div class="row">
		{% for chain in chains %}
		<div class="three columns">
			<h5>{{ chain.name }}</h5>
			<p>{{ chain.reviews|length }}</p>
		</div>
		{% endfor %}
	</div>
</div>

<div class="container">
    <h2>Reviews</h2>
    {% for review in reviews %}
        <div class="row review">
            <div class="review-text">
                <p><strong>{{ review.name }}</strong> 
                <i>{{ review.date|date }}</i> <br>
                {{ review.email }} {{ review.store.name }}</p>
                <p>
                {{ review.comments|nl2br }}
                </p>
                {% if review.images|length > 0 %}
                    {% for image in review.images %}
                    <a href="/img/full/{{ image.filename }}.jpg"><img src="/img/thumbnails/{{ image.filename }}.jpg"></a>
                    {% endfor %}
               {% endif %}
                <p>
                <a href="/reviews/delete/{{ review.webid }}" class="button">Delete</a>
                <a href="/reviews/view/{{ review.webid }}" class="button">Author</a>
                <a href="/reviews/feature/{{ review.webid }}"
                    class="button">Set Featured</a>
                </p>
            </div>
            <div class="review-stars">
                <p>
                {{ partial('partials/rating', ['rating': review.flavour]) }} <span class="star-label">Flavour</span> <br>
                {{ partial('partials/rating', ['rating': review.mouthfeel]) }} <span class="star-label">Mouthfeel</span> <br>
                {{ partial('partials/rating', ['rating': review.coating]) }} <span class="star-label">Coating</span> <br>
                {{ partial('partials/rating', ['rating': review.sauces]) }} <span class="star-label">Sauces</span> <br>
                {{ partial('partials/rating', ['rating': review.overall]) }} <span class="star-label">Overall</span> <br>
                </p>
            </div>
        </div>
    {% endfor %}
</div>
