setting = require '../setting'
Book = require '../lib/book'
BookModel = require '../models/book'
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

    app.get '/book/collection/:isbn',(req,res)->
        info =
            isbn: req.params.isbn
            uid: req.session.user.id
            stime: new Date()
        BookModel.getCollection info,(err,result)->
            if result.length > 0
                res.redirect '/people/' + info.uid
            else
                book = new Book info
                book.detail (err,data) ->
                    bkDetail =
                        title: data.title
                        isbn: data.isbn13
                        author: data.author
                        image: data.image
                        summary: data.summary || ''
                        price: data.price
                        pages: data.pages
                        publisher: data.publisher
                        ctime: new Date()
                    BookModel.add bkDetail,(err,result) ->
                        if err
                            console.log err
                        else
                            BookModel.addCollection info,(err,result)->
                                res.redirect '/people/' + info.uid

        

