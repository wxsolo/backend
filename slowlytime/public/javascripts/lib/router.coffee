# author huip(penghui1012@gmail.com)
# This file is the router parse of this app
define (require,exports,module)->
    class Router
        current = ''
        constructor: ->
          @url = window.location.href
          urlHash @url
        on:(router,next)->
          if router is current
            next null,router
          else 
            next 'not current',null
        urlHash = (url)->
          urls = url.split '/'
          current = urls[3]

    module.exports = Router
