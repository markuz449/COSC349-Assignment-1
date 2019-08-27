<div class="row jumbo" style="text-align: center">
<div class="container">
    <h2>Register </h2>
</div>
</div>

<div class="row mt-2 mb-2">
<div class="container">
{{ content() }}
{{ form('register', 'id': 'registerForm', 'onbeforesubmit': 'return false', 'class': 'offset-by-three six columns') }}

    <fieldset>

        <div class="control-group">
            {{ form.label('name', ['class': 'control-label']) }}
            <div class="controls">
                {{ form.render('name', ['class': 'u-full-width form-control']) }}
            </div>
        </div>

        <div class="control-group">
            {{ form.label('username', ['class': 'control-label']) }}
            <div class="controls">
                {{ form.render('username', ['class': 'u-full-width form-control']) }}
            </div>
        </div>

        <div class="control-group">
            {{ form.label('email', ['class': 'control-label']) }}
            <div class="controls">
                {{ form.render('email', ['class': 'u-full-width form-control']) }}
        <div class="control-group">
            {{ form.label('password', ['class': 'control-label']) }}
            <div class="controls">
                {{ form.render('password', ['class': 'u-full-width form-control']) }}
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="repeatPassword">Repeat Password</label>
            <div class="controls">
                {{ password_field('repeatPassword', 'class': 'u-full-width form-control') }}
                <div class="alert" id="repeatPassword_alert">
                </div>
            </div>
        </div>

        <div class="form-actions">
            {{ submit_button('Register', 'class': 'btn btn-primary', 'onclick': 'return SignUp.validate();') }}
	    <p class="help-block">By signing up, you accept <a href="/about/privacy">terms of use and privacy policy</a>.</p>
        </div>

    </fieldset>
</form>
</div>
</div>
