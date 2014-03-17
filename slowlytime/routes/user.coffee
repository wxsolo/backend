
#
# * User models
# 
setting = require '../setting'
Dbauth = require '../lib/dbauth'
crypto = require 'crypto'
User = require '../models/user'
status = {}
module.exports = (app) ->
    
    app.get '/user/auth/douban',(req,res)->
        res.redirect 'https://www.douban.com/service/auth2/auth?response_type=code&client_id='+setting.douban_auth.client_id+'&redirect_uri='+setting.douban_auth.dev_host+'users/callback'
    
    app.get '/user/callback',(req,res)->
        auth = new Dbauth req.url
        auth.getUserInfo (err,data)->
            if not err
                res.json data
            else
                res.redirect '/login'
   
    app.post '/user/reg',(req,res)->
        md5 = crypto.createHash('md5')
        regUser = 
          name: req.body.username
          email: req.body.email
          password: md5.update(req.body.password).digest('base64')
        User.get regUser,(err,user)->
            if user?
                status.errorCode = 101
                res.json status
                return false
            User.save regUser,(err,info)->
                if err
                    status.errorCode = 102
                    res.json status
                else
                    status.errorCode = 201
                    req.session.user = info
                    res.json status
    
    app.post '/user/login',(req,res)->
        md5 = crypto.createHash('md5')
        loginInfo =
            email: req.body.email
            password: md5.update(req.body.password).digest('base64')
        User.get loginInfo,(err,user)->
            if not user?
                status.errorCode = 103
            else if loginInfo.password isnt user.password
                #104 means user password is error
                status.errorCode = 104
            else
                # login success
                req.session.user = user
                status.errorCode = 202
            res.json status

    app.get '/user',(req,res)->
        checkLogin req,res
        res.render 'index',
            title: setting.title
            brand: setting.brand
    app.get '/user/setting',(req,res)->
        res.render 'user/setting',
            title: setting.title
            brand: setting.brand
    
    checkLogin = (req,res)->
        res.redirect '/login' if req.session.user?
