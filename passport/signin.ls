require! ['../models/User', 'bcrypt', 'passport-local']
local-strategy = passport-local.Strategy

valid-password = (user, password)-> bcrypt.compare-sync password, user.password

module.exports = (passport)!-> passport.use 'signin', new local-strategy {username-field: 'email', pass-req-to-callback: true}, (req, email, password, done)!->
  (error, user) <-! User.find-one email: email
  if error
    console.log  'Error in sign-in: ', error
    return done error

  if !user
    done null, false, {error: true, reason: 'email-invalid unregistered'}
  else if not valid-password user, password
    done null, false, {error: true, reason: 'password-invalid'}
  else if user.state is 'unverified'
    done null, false, {error: true, reason: 'email-invalid unverified'}
  else
    done null, user