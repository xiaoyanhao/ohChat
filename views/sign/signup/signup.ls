$ !->

  $ '#signup form' .submit (event)!->
    event.prevent-default!
    email = event.target.email.value
    username = event.target.username.value
    password = event.target.password.value
    password-verified = event.target.password_verified.value

    if password isnt password-verified
      $ @ .add-class 'password-invalid'
      return false
    else
      $ @ .remove-class 'password-invalid'

      $.post '/signup', {email: email, username: username, password: password}, (result)!~>
        if result.error is true
          $ @ .add-class result.reason
        else
          $ @ .remove-class 'email-invalid registered'
          $ '#signup-verify' .open-modal!

$ !->
  $ '#signup' .hammer!bind 'swiperight', (event)!->
    $ '#sign-nav .signin-tab' .trigger 'click'
