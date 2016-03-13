$ !->

  $ '#verify-email form' .submit (event)!->
    event.prevent-default!
    verify-code = event.target.verify-code.value
    $.post '/verify', {verify-code: verify-code}, (result)!~>
      $ @ .remove-class 'verify-code-invalid code-invalid expired'
      console.log result
      if result.error
        $ @ .add-class result.reason
      else
        $ '#sign' .remove-class 'verify'
        $ '#sign' .add-class 'reset'
