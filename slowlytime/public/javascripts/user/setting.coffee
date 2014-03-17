define (require,exports,module) ->
    $ = require '$'
    Kit = require '../lib/kit'
    class Setting
        constructor:->
          @init()
        init: ->
          events()
        events = ->
           $('.setting-nav li').click ->
               settingNav $(this)

        settingNav = (el)->
           current = el.find('a').attr('href').split('#')[1]
           el.addClass('active').siblings().removeClass('active')
           $(".setting-item li[data-key='"+current+"']").addClass('show'
           ).removeClass('hide').siblings().removeClass('show').addClass('hide');
    
    module.exports = Setting
