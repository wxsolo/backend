define (require,exports,module)->
    $ = require '$'
    Kit = require '../lib/kit'
    class Register
        constructor: ->
          @init()
        $uname = $ '.reg-uname'
        $email = $ '.reg-email'
        $password = $ '.reg-password'
        $btn = $ '.reg-btn'
        $errorTip = $ '.error-tip'
        url =  '/user/reg'
        bok = false
        init: ->
          events()
        events = ->
          $btn.click ->
            doRegister()
          $uname.focus ->
            Kit.errorTip $errorTip,'','hide'
          $email.focus ->
            Kit.errorTip $errorTip,'','hide'
          $password.focus ->
            Kit.errorTip $errorTip,'','hide'
        checkInvalid = (data) ->
          if data.username.length < 4
            Kit.errorTip $errorTip,'用户名不得小于四位!','show'
          else if not Kit.isValidEmail data.email
            Kit.errorTip $errorTip,'邮箱不合法!','show'
            bok = false 
          else if data.password.length < 6
            kit.errorTip $errorTip,'密码不得小于六位!','show'
            bok = false
          else
            bok = true
        msgHandle = (msg)->
          if msg.errorCode is 201
            Kit.redirect '/user'
            return false
          if msg.errorCode is 101
            Kit.errorTip $errorTip,'用户名已经存在!','show'
        doRegister = ->
          data =
            username: $uname.val()
            email: $email.val()
            password: $password.val()
          if checkInvalid data
            $.ajax
              url: url
              type: 'post'
              data: data
              success:(msg)->
                msgHandle msg
    
    module.exports = Register
