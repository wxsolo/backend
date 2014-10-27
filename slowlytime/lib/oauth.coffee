module.exports = 
  isLogin: (req) ->
    return true if req.session.user?
    return false

