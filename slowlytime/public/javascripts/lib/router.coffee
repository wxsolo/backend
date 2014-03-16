define (require,exports,module)->
    class Router
        constructor: ->
          @url = window.location.href
          @init @url
        current = ''
        init:(url)->
          urlHash url
        urlHash = (url)->
          urls = url.split '/'
          current = urls[3]
        on:(router,next)->
          if router is current
            next null,router
          else 
            next 'not current',null
    
    module.exports = Router
