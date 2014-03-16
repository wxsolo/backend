define (require,exports,module)->
    Kit = {
        
        isValidEmail: (email)->
            reMail = /^(?:[a-z\d]+[_\-\+\.]?)*[a-z\d]+@(?:([a-z\d]+\-?)*[a-z\d]+\.)+([a-z]{2,})+$/i
            return reMail.test email
        # error tip 
        errorTip: (dom,msg,method)->
            if method is 'show'
                dom.html(msg).css 'color','#b94a48'
            else
                dom.html ''
        redirect: (location)->
            window.location.href = location
    }

    module.exports = Kit
