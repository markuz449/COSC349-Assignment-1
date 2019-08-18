{{ content() }}

<div class="row">
<div class="container">
    <div class="six columns offset-by-three">
            <h2>Log In</h2>
        {{ form('session/start', 'role': 'form') }}
            <fieldset>
                <div class="form-group">
                    <label for="email">Username/Email</label>
                    <div class="controls">
                        {{ text_field('email', 'class': "u-full-width", "autofocus": true) }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="controls">
                        {{ password_field('password', 'class': "u-full-width") }}
                    </div>
                </div>
                <div class="form-group">
                    {{ submit_button('Login', 'class': 'button') }}
                </div>
            </fieldset>
        </form>
    </div>
</div>
</div>
