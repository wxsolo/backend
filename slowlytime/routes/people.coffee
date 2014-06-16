
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
            People.getRead req.params.id, (err,result)->
                books =
                    collection: []
                    reading: []
                    readed: []
                for list in result
                    if list.status == 0
                        books.collection.push list
                    else if list.status == 1
                        books.reading.push list
                    else
                        books.readed.push list
                
                res.render 'people/index',
                    title: setting.title
                    brand: setting.brand
                    user: req.session.user
                    people: people[0]
                    books: books

