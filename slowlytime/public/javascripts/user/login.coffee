define (require,exports,module) ->
    $ = require '$'
    Kit = require '../lib/kit'
    class Login
        constructor:->
          @init()
        $email = $ '.login-email'
        $password = $ '.login-password'
        $errorTip = $ '.error-tip'
        $btn = $ '.login-btn'
        url = '/user/login'
        bok = false
        init: ->
          events()
        events = ->
          $btn.click ->
            doLogin()
          $email.focus ->
            Kit.errorTip $errorTip,'','hide'
          $password.focus ->
            Kit.errorTip $errorTip,'','hide'
        checkInvalid = (data) ->
          if not Kit.isValidEmail data.email
            Kit.errorTip $errorTip,'邮箱地址错误！','show'
            bok = false 
          else if data.password.length < 6
            Kit.errorTip $errorTip,'密码小于6位','show'
            bok = false
          else
            bok = true
          return bok
        msgHandle = (msg)->
          if msg.errorCode is 202
            Kit.redirect '/admin'
          else if msg.errorCode is 103
            Kit.errorTip $errorTip,'用户不存在！','show'
          else if msg.errorCode is 104
            Kit.errorTip $errorTip,'用户名或密码错误!','show'
        doLogin = ->
          data = 
            email:$email.val()
            password:$password.val()
          if checkInvalid data
            $.ajax
              url: url
              type: 'post'
              data: data
              success:(msg)->
                msgHandle msg 

    module.exports = Login
