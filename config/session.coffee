module.exports =
  session:
    secret: process.env.COOKIE_SECRET
    cookie:
      maxAge: parseInt process.env.COOKIE_EXPIRE || '600000', 10
      httpOnly: true
      secure: false  # assume front end (nginx) directly connected to this app
