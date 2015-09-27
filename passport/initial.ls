require! ['./signin', './signup', '../models/User']

module.exports = (passport)->
  passport.serialize-user (user, done)!->
    done null, user._id

  passport.deserialize-user (id, done)!->
    User.find-by-id id, (err, user)!->
      done err, user

  signup passport
  signin passport