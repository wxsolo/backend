
#
# * GET home page.
# 

setting = require '../setting'
People = require '../models/people'
module.exports = (app) ->
    app.get '/people/:id',(req,res)->
        if  not req.params.id?
            req.params.id = req.session.user.id 
        People.get req.params.id, (err,people) ->
            books =
                collection: []
                reading: []
                readed: []
            People.getCollection req.params.id,1,(err,collection)->
                books.collection = collection.books
                People.getDo req.params.id,1,(err,reading)->
                    books.reading = reading.books
                    People.getReaded req.params.id,1,(err,readed)->
                        books.readed = readed.books
                        res.render 'people/index',
                            title: setting.title
                            brand: setting.brand
                            user: req.session.user
                            people: people[0]
                            books: books
    
    app.get '/people/:id/collect',(req,res) ->
        if not req.query.start
            start = 1
        else
            start = req.query.start
        People.getCollection req.params.id,start,(err,collection)->
            res.json collection
