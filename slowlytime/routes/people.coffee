
#
# * GET home page.
# 

setting = require '../setting'
People = require '../models/people'
module.exports = (app) ->
    app.get '/people/:id',(req,res)->
        if  not req.params.id?
            req.params.id = req.session.user.id 
        People.get req.params.id, (err,result) ->
            res.render 'people/index',
                title: setting.title
                brand: setting.brand
                user: req.session.user
                people: result[0]

