$ !->
  $ '.home-nav .tab' .click !->
    icon = $ @ .find '.material-icons'
    tabs = $ '.home-nav .tab' .find '.material-icons'
    for tab in tabs when ($ tab .text!search '_outline') is -1
      $ tab .text ($ tab .text!concat '_outline')
    icon.text (icon.text!replace '_outline', '')
