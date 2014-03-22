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
           $('.profile-update').click ->
               updateProfile()
           $('.account-update').click ->
               updateAccount()
        settingNav = (el)->
           current = el.find('a').attr('data-key')
           el.addClass('active').siblings().removeClass('active')
           $(".setting-item li[data-key='"+current+"']").addClass('show'
           ).removeClass('hide').siblings().removeClass('show').addClass('hide');

        updateProfile = ->
           $nickname = $('#nickname').val()
           $motto = $('#motto').val()
           url = '/user/update/profile'
           if not $nickname
               errorTip 'nickname must not empty!'
               return false
           if not $motto
               errorTip 'motto must not empty!'
               return false
           accountInfo =
               'name': $nickname
               'motto': $motto
           $.ajax
               url: url
               type: 'post'
               data: accountInfo
               success:(msg)->
                errorTip '修改成功！'  if msg.errorCode is 203
       
       updateAccount = ->
            url = '/user/update/account'
            $email = $('#email').val()
            $currentPwd = $('#current-password').val()
            $newPwd = $('#new-password').val()
            $confirmPwd = $('#confirm-password').val()
            if not $email
                errorTip 'email must not empty!'
                return false
            
            if not checkCurrentPwd $currentPwd
                errorTip 'current password is false'
                return false
            
            if $newPwd.length < 6 and $confirmPwd.length < 6
                errorTip 'new password is too short'
                return false
            if $newPwd isnt $confirmPwd
                errorTip 'twice input password is not equal'
                return false
            pwdInfo = 
                email: $email
                password: $newPwd
            $.ajax
               url: url
               type: 'post'
               data: pwdInfo
               success:(msg)->
                errorTip '修改成功！'  if msg.errorCode is 204
        
        # 检测密码正确性
        checkCurrentPwd = (pwd)->
            url = '/user/check/password'
            bok = false
            $.ajax
               url: url
               async: false
               type: 'post'
               data:
                   password: pwd
               success:(msg)->
                   bok  = true if msg.errorCode is 204
            return bok
        errorTip = (msg)->
           $('.setting-tips').html msg

           
    module.exports = Setting
