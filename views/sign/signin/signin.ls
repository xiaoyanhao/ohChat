$ !->

  $ '#signin form' .submit (event)!->
    event.prevent-default!
    email = event.target.email.value
    password = event.target.password.value

    $.post '/signin', {email: email, password: password}, (result)!~>
      $ @ .remove-class 'email-invalid unregistered unverified password-invalid'

      if result.error is true
        $ @ .add-class result.reason
      else
        location.replace result.url


  $ '#signin' .hammer!bind 'swipeleft', (event)!->
    $ '#sign-nav .signup-tab' .trigger 'click'
