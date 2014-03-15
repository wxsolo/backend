
#
# * GET home page.
# 

setting = require '../setting'
module.exports = (app) ->
    app.get '/',(req,res)->
        res.render 'index',
            title: setting.title
            brand: setting.brand
