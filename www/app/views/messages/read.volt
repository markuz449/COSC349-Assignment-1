<div class="row">
    <div class="container">
        <h1>Reading Message</h1>
            <p><strong>Name: </strong> {{ message.name }}</p>
            <p><strong>Email: </strong> {{ message.email }}</p>
            <p><strong>Sent: </strong> {{ message.datetime }}</p>
            <p>{{ message.message }}</p>
            {{ link_to('messages/', 'Back to Messages', 'class': 'button') }}
            {{ link_to('messages/delete/' ~ message.id, 'Delete', 'class': 'button u-pull-right') }}
    </div>
</div>
