require! <[mongoose]>

user-schema = mongoose.Schema do
  username: String
  password: String
  email: String
  state: String
  signup-token: String
  reset-password-token: String
  reset-password-expire: String
  profile:
    gender: String
    birthday: String


module.exports = mongoose.model 'User', user-schema