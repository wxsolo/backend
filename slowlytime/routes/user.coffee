
#
# * GET home page.
# 
setting = require '../setting'
Dbauth = require '../lib/dbauth'
module.exports = (app) ->
    
    app.get '/users/auth/douban',(req,res)->
        res.redirect 'https://www.douban.com/service/auth2/auth?response_type=code&client_id='+setting.douban_auth.client_id+'&redirect_uri='+setting.douban_auth.dev_host+'users/callback'
    
    app.get '/users/callback',(req,res)->
        auth = new Dbauth req.url
        auth.getUserInfo (err,data)->
            if not err
                res.json data
            else
                res.redirect '/login'
        
