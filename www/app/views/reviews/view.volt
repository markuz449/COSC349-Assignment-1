<div class="row">
<div class="container">
    {{ flash.output() }}
    {{ content() }}
{% for review in reviews %}
        <div class="row review">
            <div class="review-text">
                <p><strong>{{ review.name }}</strong> 
                <i>{{ review.date|date }}</i></p>
                <p>
                {{ review.comments|nl2br }}
                </p>
                <p>
                <a href="" class="button">Delete</a>
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
</div>
