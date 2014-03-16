$(document).ready ->
    class Login
        constructor:->
          @init()
        $email = $ '.login-email'
        $password = $ '.login-password'
        $errorTip = $ '.error-tip'
        $btn = $ '.login-btn'
        url = '/api/u/login'
        bok = false
        init: ->
          events()
        events = ->
          $btn.click ->
            doLogin()
          $email.focus ->
            errorTip $errorTip,'','hide'
          $password.focus ->
            errorTip $errorTip,'','hide'
        checkInvalid = (data) ->
          if not isValidEmail data.email
            errorTip $errorTip,'invalid email address!','show'
            bok = false 
          else if data.password.length < 6
            errorTip $errorTip,'password less than 6 charaters','show'
            bok = false
          else
            bok = true
          return bok
        msgHandle = (msg)->
          if msg.errorCode is 202
            window.location.href = '/admin'
          else if msg.errorCode is 103
            errorTip $errorTip,'user not exist!','show'
          else if msg.errorCode is 104
            errorTip $errorTip,'username or password error!','show'
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
    
    class Register
        constructor: ->
          @init()
        $uname = $ '.register-username'
        $email = $ '.register-email'
        $password = $ '.register-password'
        $btn = $ '.register-btn'
        $errorTip = $ '.error-tip'
        url =  '/api/u/register'
        bok = false
        init: ->
          events()
        events = ->
          $btn.click ->
            doRegister()
          $uname.focus ->
            errorTip $errorTip,'','hide'
          $email.focus ->
            errorTip $errorTip,'','hide'
          $password.focus ->
            errorTip $errorTip,'','hide'
        checkInvalid = (data) ->
          if data.username.length < 4
            errorTip $errorTip,'Invalid user name!','show'
          else if not isValidEmail data.email
            errorTip $errorTip,'Invalid email address!','show'
            bok = false 
          else if data.password.length < 6
            errorTip $errorTip,'Password less than 6 characters!','show'
            bok = false
          else
            bok = true
        msgHandle = (msg)->
          if msg.errorCode is 201
            window.location.href = '/admin'
            return false
          if msg.errorCode is 101
            errorTip $errorTip,'user acount is already exist','show'
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

# router config 
    router = new Router()
       
    router.on 'index',(err,current)->
        if current
          $('.navbar-nav li').eq(0).addClass('active').siblings().removeClass('active')
    router.on 'login',(err,current)->
        if current
          $('.navbar-nav li').removeClass('active')
          login = new Login()
    router.on 'register',(err,current)->
        if current
          register = new Register()
          $('.navbar-nav li').removeClass('active')
    router.on 'about',(err,current)->
        if current
          $('.navbar-nav li').eq(2).addClass('active').siblings().removeClass('active')
    router.on 'words',(err,current)->
        if current
            words = new Words()
            $('.navbar-nav li').eq(1).addClass('active').siblings().removeClass('active')
    router.on 'p',(err,current)->
        if current 
            $('.navbar-nav li').removeClass('active')
    router.on 'w',(err,current)->
        if current 
            $('.navbar-nav li').removeClass('active')

# is valid email
    isValidEmail = (email)->
        reMail = /^(?:[a-z\d]+[_\-\+\.]?)*[a-z\d]+@(?:([a-z\d]+\-?)*[a-z\d]+\.)+([a-z]{2,})+$/i
        return reMail.test email
# error tip 
    errorTip = (dom,msg,method)->
        if method is 'show'
            dom.html(msg).css 'color','#b94a48'
        else
            dom.html ''
