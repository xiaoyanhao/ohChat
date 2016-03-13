$ !->
  create-home-FSM!

create-home-FSM = !->
  options =
    name: 'home'
    dom: '#home'
    runtime:
      initial-state: 'chats'
      transitions:
        'chats,discovery,me -> contacts':
          'click': '#home-nav .contacts'
        'chats,contacts,me -> discovery':
          'click': '#home-nav .discovery'
        'chats,contacts,discovery -> me':
          'click': '#home-nav .me'
        'discovery,contacts,me -> chats':
          'click': '#home-nav .chats'

  home-FSM = new FSM options
