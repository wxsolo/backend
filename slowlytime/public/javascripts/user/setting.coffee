define (require,exports,module) ->
    $ = require '$'
    Kit = require '../lib/kit'
    class Setting
        that = ''
        constructor:->
          @init()
        init: ->
          bindEvent()
          that = @
        events =
            ".setting-nav click": "settingNav"
        event = ->
           $('.setting-nav li').click ->
               settingNav $(this)
        settingNav: (el)->
           current = el.find('a').attr('data-key')
           el.addClass('active').siblings().removeClass('active')
           $(".setting-item li[data-key='"+current+"']").addClass('show'
           ).removeClass('hide').siblings().removeClass('show').addClass('hide');
        bindEvent = ()->
            for key of events
                args = key.split(' ')
                ele = args[0]
                evt = args[1]
                func = events[key]
                $(ele).bind evt,()->
                    that[func]()
                    


            

    
    module.exports = Setting
