define (require,exports,module)->
    $ = require '$'
    scroll = ()->
        $(window).scroll ()->
           if $(this).scrollTop() >= 245 
               $('.header').css {'position':'fixed','top': '-245px'}
           else
               $('.header').css {'position':'static'}

    module.exports = scroll
         
