$ !->
  $ '.chat-more-slider' .openFAB!
  $ '.chat-more-slider' .closeFAB!

  $ '#chat-more a.btn-floating' .click !->
    $ '#chat-input' .remove-class 'emoji'
    $ '#chat-input' .remove-class 'voice'
    $ '#chat-input' .toggle-class 'more'

    if $ '#chat-input' .has-class 'more'
      $ '.chat-more-slider' .openFAB!
    else
      $ '.chat-more-slider' .closeFAB!
