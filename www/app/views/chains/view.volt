<div class="row jumbo">
    <div class="container">
        <div class="six columns" >
            <h1>{{ chain.name }}</h1>
            <h3>{{ partial('partials/rating', ['rating': chain.rating]) }}</h3>
            <p>Based on {{ chain.rating_count }} reviews</p>
        </div>
        <div class="six columns">
            <p>{{ partial('partials/rating', ['rating': chain.avg_flavour]) }} Flavour</p>
            <p>{{ partial('partials/rating', ['rating': chain.avg_mouthfeel]) }} Mouthfeel</p>
            <p>{{ partial('partials/rating', ['rating': chain.avg_coating]) }} Coating</p>
            <p>{{ partial('partials/rating', ['rating': chain.avg_sauce]) }} Sauces</p>
        </div>
    </div>
</div>
<div class="row mt-1">
    <div class="container">
    {{ flashSession.output() }}
    {{ content() }}
        <div class="column">
            <h2>Prices</h2>
            <table>
                <tr>
                    <th>Price</th>
                    <th>Number</th>
                    <th>Price per Nugget</th>
                </tr>
                {% for price in chain.prices %}
                <tr>
                    <td>{{ price.price|money }}</td>
                    <td>{{ price.number }}</td>
                    <td>{{ price.per|money }}</td>
                </tr>
                {% endfor %}
            </table>
            <p>Prices vary slightly from place to place. Are these prices not right? <a href="/contact">Let us know!</a></p>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="twelve columns">
            <h2>Reviews
                <a href="/review/{{ chain.nicename }}" class="button button-primary u-pull-right">Write a Review</a>
            </h2>
            {% if chain.reviews|length == 0 %}
               <p>No reviews yet! Be the first</p>
            {% endif %}
        </div>
    </div>
    {% for review in chain.reviews %}
        {% if review.comments is null %}
            {% continue %}
        {% endif %}
        <div class="row review {% if review.featured %}featured{%endif%}" itemscope itemtype="http://schema.org/Review">
              <span itemprop="itemReviewed" itemscope itemtype="https://schema.org/Thing">
                  <meta itemprop="name" content="{{ chain.name }} Chicken Nuggets">
              </span>
            <div class="review-text">
                <p>
                <strong>
                    <span itemprop="author" itemscope itemtype="https://schema.org/Person">
                    <span itemprop="name">{{ review.name }}</span>
                </span>
                </strong><br>
                <i itemprop="datePublished">{{ review.date|date }}</i></p>
                <p itemprop="reviewBody">
                {{ review.comments|nl2br }}
                </p>
                {% if review.images|length > 0 %}
                    {% if review.approved %}
                        {% for image in review.images %}
                        <a href="/img/full/{{ image.filename  }}.jpg" target="_blank">
                            <img src="/img/thumbnails/{{ image.filename }}.jpg">
                        </a>
                         {% endfor %}
                     {% else %}
                     <small><i>
                     Images are pending review
                         </i></small>
                     {% endif %}
                {% endif %}
                {#
                <p class="thumbs">
                <a onclick="callAjax(this, '/rate/up/{{ review.webid }}')" content="nofollow"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-thumbs-up"><path d="M14 9V5a3 3 0 0 0-3-3l-4 9v11h11.28a2 2 0 0 0 2-1.7l1.38-9a2 2 0 0 0-2-2.3zM7 22H4a2 2 0 0 1-2-2v-7a2 2 0 0 1 2-2h3"></path></svg></a>
                <a onclick="callAjax(this, '/rate/down/{{ review.webid }}')" content="nofollow"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-thumbs-down"><path d="M10 15v4a3 3 0 0 0 3 3l4-9V2H5.72a2 2 0 0 0-2 1.7l-1.38 9a2 2 0 0 0 2 2.3zm7-13h2.67A2.31 2.31 0 0 1 22 4v7a2.31 2.31 0 0 1-2.33 2H17"></path></svg></a>
                <span>Was this review sweet or sour?</span>
                </p>
                #}
            </div>
            <div class="review-stars">
                <span itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
                <p>
                {{ partial('partials/rating', ['rating': review.flavour]) }} <span class="star-label">Flavour</span> <br>
                {{ partial('partials/rating', ['rating': review.mouthfeel]) }} <span class="star-label">Mouthfeel</span> <br>
                {{ partial('partials/rating', ['rating': review.coating]) }} <span class="star-label">Coating</span> <br>
                {{ partial('partials/rating', ['rating': review.sauces]) }} <span class="star-label">Sauces</span> <br>
                {{ partial('partials/rating', ['rating': review.overall]) }} <span class="star-label">Overall</span> <br>
                <meta itemprop="ratingValue" content="{{ review.overall }}">
                </p>
                </span>
            </div>
        </div>
    {% endfor %}
    <div class="row mb-2 mt-2" style="text-align: center;">
        <a href="/review/{{ chain.nicename }}" class="button button-primary">Write a Review</a>
    </div>
</div>
<style>
.thumbs {
    margin-bottom: 0;
}
.thumbs span {
    font-size: 0.8em;
}
.thumbs a {
    color: #516980;
    cursor: pointer;
}
.thumbs a:hover:not(.disable) svg {
    color: #213140;
    transform: scale(1.2);
}
.selected svg {
    transform: scale(1.2);
    color: #213140;
}
.feather.feather-thumbs-down {
    height: 1.2em;
    margin-bottom: -0.3em;
}
.feather.feather-thumbs-up {
    height: 1.2em;
    margin-bottom: -0.1em;
}
</style>
    <script>
function callAjax(e, url){
    if (e.classList.contains("selected") || e.classList.contains("disable")) {
        return;
    }
    e.classList.add("selected");
    for (var i = 0; i < e.parentElement.children.length; i++) {
        e.parentElement.children[i].classList.add("disable");
    }
    e.parentElement
    var xmlhttp;
    // compatible with IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
        }
    }
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}
    </script>
