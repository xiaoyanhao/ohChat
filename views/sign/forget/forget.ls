$ !->

  $ '#forget-password form' .submit (event)!->
    event.prevent-default!
    email = event.target.email.value
    $.post '/forget', {email: email}, (result)!~>
      $ @ .remove-class 'email-invalid unregistered'
      console.log result
      if result.error
        $ @ .add-class result.reason
      else
        $ '#sign' .remove-class 'forget'
        $ '#sign' .add-class 'verify'

        set-countdown!

set-countdown = !->
  count = $ '#verify-email .countdown' .text!
  return if count is '0'
  count--
  $ '#verify-email .countdown' .text count
  set-timeout set-countdown, 1000
