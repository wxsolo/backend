
#
# * GET home page.
# 

setting = require '../setting'
request = require 'request'
module.exports = (app) ->
    
    app.get '/users/auth/douban',(req,res)->
        res.redirect 'https://www.douban.com/service/auth2/auth?response_type=code&client_id='+setting.douban_auth.client_id+'&redirect_uri='+setting.douban_auth.dev_host+'users/callback'
    
    app.get '/users/callback',(req,res)->
        code = parseCode(req.url)
        res.redirect '/' if code == 'access_denied'
        url = 'https://www.douban.com/service/auth2/token'
        request.post url,
            form: 
                client_id: setting.douban_auth.client_id
                client_secret: setting.douban_auth.client_secret
                redirect_uri: setting.douban_auth.dev_host
                grant_type: setting.douban_auth.grant_type
                code:code
            (error,response,body)->
                userInfo = JSON.parse(body) if not error and response.statusCode = 200
                request.get 'https://api.douban.com/v2/user/~me',
                    headers:
                        'Authorization': 'Bearer ' + userInfo.access_token
                    (error,response,body)->
                        console.log body

    parseCode = (url)->
        return url.split('=')[1]
