<div class="row jumbo">
    <div class="container">
        <div class="column" style="text-align: center;">
            {% if check %}
            <h1>Write a Review</h1>
            {% else %}
            <h1>Write a Review</h1>
            <h2><small>{{ chain.name }}</small></h2>
            {% endif %}
        </div>
    </div>
</div>

<div class="container">
<div class="offset-by-three six columns">
{{ content() }}
</div>
</div>

<form method="post">
<div class="container">
<div class="row mb-1 mt-1">
<div class="offset-by-three six columns">
{{ form.label('name') }}
{{ form.render('name') }}
<span class="hint">This will be visible above your review</span>
{{ form.label('email') }}
{{ form.render('email') }}
<span class="hint">Your email address will never be shared. It is only used if you want to update a review in the future.</span>
</div>
</div>

{% if check is true %}
<div class="row mb-1 mt-1">
<div class="offset-by-three six columns">
{{ form.label("chain") }}
{{ form.render("chain") }}
</div>
</div>
{% endif %}

{% set points = ['flavour', 'mouthfeel', 'coating', 'sauces', 'overall'] %}

{% set scale = ['Very Bad', 'Below Average','Average', 'Above Average','Very Good'] %}

<div class="row mt-1 mb-1">
<div class="offset-by-three six columns">
{% for point in points %}
<fieldset class="rating">
<span class="star-label">{{ point|capitalize }}</span>
{% for i in 5..1 %}
    <input type="radio" id="{{ point }}star{{ i }}" name="{{ point }}" value="{{ i }}" {% if form.get(point).getValue() is i %}checked{% endif %}/><label class = "full" for="{{ point }}star{{ i }}" title="{{ scale[i-1] }}"></label>
{% endfor %}
</fieldset>
{% endfor %}
</div>
</div>

<div class="row mt-1 mb-1">
<div class="offset-by-three six columns">
{{ form.label('comments') }}
{{ form.render('comments') }}
<span class="hint">Optional</span>

<input class="button" type="submit" value="Submit">
</div>
</div>
</div>
</div>
</form>




<style>
fieldset { margin: 0; padding: 0;  }
.hint {
    color: #606060;
    font-size: 0.7em;
    display: block;
    margin-top: -1em;
    margin-bottom: 1.5em;

}

/****** Style Star Rating Widget *****/

.rating { 
border: none;
float: right;
clear: left;
width: 100%;
}

.rating > input { display: none;  } 
.rating > label:before { 
display: inline-block;
content: "\2605";
font-size: 2em;
}

.rating > label { 
color: #ddd; 
float: right; 
padding-left: 1rem;
}

.rating > label:hover {
cursor: pointer;
}

.rating .star-label {
margin: 0.9em 0 0 0;
display: inline-block;
font-weight: bold;
}

/***** CSS Magic to Highlight Stars on Hover *****/

.rating > input:checked ~ label, /* show gold star when clicked */
    .rating:not(:checked) > label:hover, /* hover current star */
    .rating:not(:checked) > label:hover ~ label { color: #213140;   } /* hover previous stars in list */

    .rating > input:checked + label:hover, /* hover current star when changing rating */
    .rating > input:checked ~ label:hover,
    .rating > label:hover ~ input:checked ~ label, /* lighten current selection */
    .rating > input:checked ~ label:hover ~ label { color: #213140;   } 
    </style>
