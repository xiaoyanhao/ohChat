$ !->
  $ '.signin-tab' .click !->
    $ '#sign-content' .remove-class 'signup'
    $ '#sign-content' .add-class 'signin'
      
  $ '.signup-tab' .click !->
    $ '#sign-content' .add-class 'signup'
    $ '#sign-content' .remove-class 'signin'

  $ '#sign-content' .hammer!bind 'swipeleft swiperight', (event)!->
    type = event.type
    if type is 'swipeleft' and $ @ .has-class 'signin'
      $ '#sign-nav .signup-tab' .trigger 'click'
    else if type is 'swiperight' and $ @ .has-class 'signup'
      $ '#sign-nav .signin-tab' .trigger 'click'