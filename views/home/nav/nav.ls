$ !->
  $ '#home-nav a.tab' .click !->
    $ '#home-nav a.tab' .remove-class 'active'
    $ @ .add-class 'active'
