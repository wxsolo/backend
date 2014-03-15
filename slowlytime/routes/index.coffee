
#
# * GET home page.
# 

setting = require '../setting'
request = require 'request'
module.exports = (app) ->
    
    app.get '/',(req,res)->
        res.render 'index',
            title: setting.title
            brand: setting.brand
   
    app.get '/login',(req,res)->
        res.render 'login',
            title: setting.title
            brand: setting.brand
   