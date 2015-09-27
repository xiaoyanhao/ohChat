require! ['passport', '../models/User']

module.exports = (app)!->

  app.post '/signup', (req, res, next)!->
    (passport.authenticate 'signup', (err, user, info)!->
      return next err if err
      if !user
        res.send info
      else
        req.log-in user, (err)!->
          return next err if err
          res.send {error: false}
    )(req, res, next)

  app.post '/signin', (req, res, next)!->
    (passport.authenticate 'signin', (err, user, info)!->
      return next err if err
      if !user
        res.send info
      else
        req.log-in user, (err)!->
          return next err if err
          res.send {error: false, url: '/'}
    )(req, res, next)

  app.get '/signout', (req, res)!-> 
    req.logout!
    res.redirect '/'

  app.get '/signup/:token', (req, res)!->
    (err, user) <-! User.find-one signup-token: req.params.token
    if !user
      res.redirect '/'
    else
      user.state = 'verified'
      (err) <-! user.save
      res.redirect '/'

  app.get '/', (req, res, next)!->
    if req.user.state is 'verified'
      console.log 'haha'
      res.render 'home/home'
    else
      res.render 'sign/sign'
