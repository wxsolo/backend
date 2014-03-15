setting = require '../setting'
request = require 'request'
class Dbauth
    
    constructor: (@url)->
    getUserInfo: (next)->
        __getToken @url,(err,token)->
            if not err
                request.get 'https://api.douban.com/v2/user/~me',
                    headers:
                        'Authorization': 'Bearer ' + token
                    (error,response,body)->
                        if not error and response.statusCode == 200
                            next null,JSON.parse(body)
                        else
                            next 'error',null

    __getToken = (url,next)->
        code = __getCode(url)
        return code if code == 'access_denied'
        request.post 'https://www.douban.com/service/auth2/token',
            form: 
                client_id: setting.douban_auth.client_id
                client_secret: setting.douban_auth.client_secret
                redirect_uri: setting.douban_auth.pro_host
                grant_type: setting.douban_auth.grant_type
                code:code
            (error,response,body)->
                if not error and response.statusCode == 200
                    next null,JSON.parse(body).access_token
                else
                    next 'error',null
    __getCode = (url)->
        return url.split('=')[1]

module.exports = Dbauth
