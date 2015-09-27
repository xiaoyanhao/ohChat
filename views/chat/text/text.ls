$ !->
  $ '#chat-text .chat-emoji' .click !->
    $ '#chat-input' .remove-class 'voice'
    $ '#chat-input' .remove-class 'more'
    $ '#chat-input' .toggle-class 'emoji'

  $ '#chat-text .input-text' .focus !->
    $ '#chat-input' .remove-class 'voice'
    $ '#chat-input' .remove-class 'more'
    $ '#chat-input' .remove-class 'emoji'

  $ '#chat-text .input-text' .keyup !->
    if ($ @ .val!) isnt ''
      $ '.chat-send-button' .remove-class 'hide'
    else
      $ '.chat-send-button' .add-class 'hide'
