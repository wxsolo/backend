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
           $nickname = $('#nickname')
           $motto = $('#motto')
           url = '/user/update/account'
           accountInfo =
               'name': $nickname.val()
               'motto': $motto.val()
           $.ajax
               url: url
               type: 'post'
               data: accountInfo
               success:(msg)->
           
    module.exports = Setting
