require! <[nodemailer]>

module.exports = (mail-options)!->
  transporter = nodemailer.create-transport do
    service: 'Gmail'
    auth:
      user: 'yanhaoxiao@gmail.com'
      pass: 'BboyMax2704'
  console.log 'send-email'
  (err, info) <-! transporter.send-mail mail-options
  if err
    console.log err
  else
    console.log 'Message sent: ' + info.response
