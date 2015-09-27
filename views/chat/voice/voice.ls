$ !->
  $ '#chat-voice .chat-voice a, #chat-voice .chat-keyboard a' .click !->
    $ '#chat-input' .remove-class 'emoji'
    $ '#chat-input' .remove-class 'more'
    $ '#chat-input' .toggle-class 'voice'
