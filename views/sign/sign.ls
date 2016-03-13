$ !->
  create-sign-FSM!

create-sign-FSM = !->
  options =
    name: 'sign'
    dom: '#sign'
    runtime:
      initial-state: 'signin'
      transitions:
        'signin -> signup':
          'click': '#sign-nav .signup-tab'
        'signup -> signin':
          'click': '#sign-nav .signin-tab'
        'signin -> forget':
          'click': '#forget-link'
        'forget,verify,reset -> signin':
          'click': '.forget-header .back'

  sign-FSM = new FSM options
