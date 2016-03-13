$ !->

  $ '#reset-password form' .submit (event)!->
    event.prevent-default!
    reset-password = event.target.password.value
    reset-password-verified = event.target.password_verified.value

    if reset-password isnt reset-password-verified
      $ @ .add-class 'password-invalid'
      return false
    else
      $ @ .remove-class 'password-invalid'

    $.post '/reset', {new-password: reset-password}, (result)!~>
      console.log result
      if result.error
        $ @ .add-class result.reason
      else
        location.replace result.url
