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
           $('.account-update').click ->
               updateAccount()
        settingNav = (el)->
           current = el.find('a').attr('data-key')
           el.addClass('active').siblings().removeClass('active')
           $(".setting-item li[data-key='"+current+"']").addClass('show'
           ).removeClass('hide').siblings().removeClass('show').addClass('hide');

        updateAccount = ->
           $nickname = $('#nickname').val()
           $motto = $('#motto').val()
           url = '/user/update/account'
           if not $nickname
               errorTip 'nickname must not empty!'
           if not $motto
               errorTip 'motto must not empty!'
           accountInfo =
               'name': $nickname
               'motto': $motto
           $.ajax
               url: url
               type: 'post'
               data: accountInfo
               success:(msg)->
        errorTip = (msg)->
            alert msg

           
    module.exports = Setting
