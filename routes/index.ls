require! <[fs]>

module.exports = (app)!->
  app.get '/*', (req, res, next)->
    console.log req.user
    if req.is-authenticated!
      next!
    else
      res.render 'sign/sign'


  for file in fs.readdirSync __dirname
    if file is 'index.js' then continue
    next-file = './' + file.substr 0, file.index-of '.'
    (require next-file) app

