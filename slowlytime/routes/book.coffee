setting = require '../setting'
Book = require '../lib/book'
request = require 'request'
module.exports = (app) ->
    
    app.get '/book/search',(req,res) ->
        book = new Book req.query
        book.search (err,data) ->
            if not err?
                res.render 'book/search',
                    title: setting.title
                    brand: setting.brand
                    user: req.session.user
                    books: data.books
                    total: data.total
                    pages: Math.ceil(data.total / 20)
                    keywords: req.query.title
    
    app.get '/book/detail/:id',(req,res) ->
        options = 
            'isbn': req.params.id
        book = new Book options
        book.detail (err,data) ->
            if not err?
                res.render 'book/detail',
                    title: setting.title
                    brand: setting.brand
                    user: req.session.user
                    book: data
    

       


