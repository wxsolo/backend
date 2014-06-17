setting = require '../setting'
ContactModel = require '../models/contact'
request = require 'request'
module.exports = (app) ->
    
    # follow a user
    app.post '/contact/follow',(req,res) ->
        if not req.session.user?
            res.redirect '/404'
        else
            if req.body.fid
                follow =
                    uid: req.session.user.id
                    fid: req.body.fid

                # TODO add follow response
                ContactModel.add follow,(err,result) ->
                    if err
                        console.log err
                    else
                        console.log result
            else
                res.redirect '/404'


