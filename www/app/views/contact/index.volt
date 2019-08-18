<div class="row jumbo">
    <div class="container">
		<h1>Contact</h1>
        <p>Got a question? Get in touch! We'd love to hear from you.</p>
    </div>
</div>

<div class="container mt-1">
	{{ content() }}
    <form action="" method="post">
      <div class="row">
        <div class="six columns">
          <label for="name">Name</label>
          <input type="text" name="name" class="u-full-width" id="name">
        </div>
        <div class="six columns">
          <label for="email">Email</label>
          <input type="email" class="u-full-width" name="email" id="email">
        </div>
      </div>
      <label for="message">Message</label>
      <textarea class="u-full-width" id="message" name="message"></textarea>
      <input class="button" type="submit" value="Send">
    </form>
	</div>
</div>
