require! ['passport', '../models/User', '../passport/send-email', 'bcrypt']

module.exports = (app)!->
  app.get '/', (req, res, next)!->
    if req.user.state is 'verified'
      console.log 'haha'
      res.render 'home/home'
    else
      res.render 'sign/sign'

  app.post '/signup', (req, res, next)!->
    (passport.authenticate 'signup', (err, user, info)!->
      return next err if err
      if !user
        res.send info
      else
        req.log-in user, (err)!->
          return next err if err
          res.send {error: false}
    ) req, res, next

  app.post '/signin', (req, res, next)!->
    (passport.authenticate 'signin', (err, user, info)!->
      return next err if err
      if !user
        res.send info
      else
        req.log-in user, (err)!->
          return next err if err
          res.send {error: false, url: '/'}
    ) req, res, next

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

  app.post '/forget', (req, res, next)!->
    email = req.body.email
    (error, user) <-! User.find-one email: email
    return next error if error
    if !user
      res.send {error: true, reason: 'email-invalid unregistered'}
    else
      token = ''
      for from 1 to 6
        token += Math.floor Math.random! * 10
      user.reset-password-token = token
      user.reset-password-expire = (new Date!).get-time! + 300 * 1000

      (error) <-! user.save
      if error
        next error
      else
        req.session.email = email
        res.send {error: false}

        mail-options =
          from: 'yanhaoxiao@gmail.com'
          to: email
          subject: 'ohChat 账户密码重置'
          html: '您正在通过验证邮件重置账户密码<br><br>' +
          '如果是本人的重置密码操作，请尽快完成重置流程。<br>' +
          '验证码：<b>' + token + '</b><br><br>'
          '如果这是非本人操作，请忽略该邮件。<br><br>' +
          'ohChat团队'

        send-email mail-options

  app.post '/verify', (req, res, next)!->
    (error, user) <-! User.find-one {email: req.session.email, reset-password-token: req.body.verify-code}
    return next error if error
    if !user
      res.send {error: true, reason: 'verify-code-invalid code-invalid'}
    else if user.reset-password-expire < (new Date!).get-time!
      res.send {error: true, reason: 'verify-code-invalid expired'}
    else
      res.send {error: false}

  app.post '/reset', (req, res, next)!->
    new-password = bcrypt.hash-sync req.body.new-password, 10
    (error, user) <-! User.find-one-and-update {email: req.session.email}, {password: new-password}
    return next error if error
    res.send {error: false, url: '/'}