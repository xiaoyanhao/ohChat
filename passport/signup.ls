require! ['../models/User', 'bcrypt', 'crypto', 'passport-local', 'nodemailer']
local-strategy = passport-local.Strategy

hash = (password)-> bcrypt.hash-sync password, 10

module.exports = (passport)!-> passport.use 'signup', new local-strategy {username-field: 'email', pass-req-to-callback: true}, (req, email, password, done)!->
  (error, user) <-! User.find-one email: email
  if error
    console.log  'Error in sign-up: ', error
    return done error

  if user
    done null, false, {error: true, reason: 'email-invalid registered'}
  else
    token = (crypto.random-bytes 20).to-string 'hex'

    new-user = new User do
      username: req.body.username
      password: hash password
      email: email
      state: 'unverified' 
      signup-token: token

    (error) <-! new-user.save
    if error
      console.log "Error in saving user: ", error
      done error
    else
      console.log "Succeed in registering user"
      done null, new-user, {error: false}
      transporter = nodemailer.create-transport do
        service: 'Gmail'
        auth:
          user: 'yanhaoxiao@gmail.com'
          pass: 'BboyMax2704'

      mail-options =
        from: 'yanhaoxiao@gmail.com'
        to: email
        subject: '欢迎使用 ohChat'
        html: '您好！' + req.body.username + '，欢迎使用 <b>ohChat</b> 社交平台！<br><br>' +
        '如果是本人的注册操作，请点击下面的安全链接进入 <b>ohChat</b>。<br>' +
        '<a href=\'http://' + req.hostname + ':7000/signup/' + token + '\'>' +
        'http://' + req.hostname + ':7000/signup/' + token + '</a><br><br>' +
        '如果这是非本人操作，请忽略该邮件。<br><br>' +
        '此致<br>ohChat团队敬上'

      (err, info) <-! transporter.send-mail mail-options
      if err
        console.log err
      else
        console.log 'Message sent: ' + info.response      