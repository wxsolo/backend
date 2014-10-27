define (require,exports,module) ->
    $ = require '$'
    class Main
        urls = '/search'
        context = $ '#bk-search'
        bkList = $ '.bk-list'
        constructor:->
          @init()
        init: ->
          events()
        events = ->
            $(document).keydown (e) ->
                if e.keyCode == 13
                    doSearch()
        doSearch = ->
            bkList.html ''
            data =
                'title': encodeURIComponent context.val()
            $.ajax
              url: urls
              type: 'post'
              data: data
              success:(msg)->
                  data = $.parseJSON msg
                  render data
        render = (data) ->
            for list in  data.books
                book = $ '<li>' + 
                            '<img src=' + list.images.small + '>' +
                            '<p>' + list.title + '</p>' + 
                            '<p>' + list.author.join(',') + '</p>' + 
                         '</li>'
                bkList.append book

            


           
    module.exports = Main
