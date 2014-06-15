# Generated by CoffeeScript 1.6.3
db = require '../lib/mysql'

User = 
    register: (info,next) ->
        db.query 'INSERT INTO user SET ?', info, (err, result)->
            next err, null if err
            next null, result
    get: (info,next) ->
        db.query "SELECT id,name,gravator,motto FROM user WHERE douban = ?", [info.douban], (err,result) ->
            if err
                next err, null
            else
                next null, result
    # TODO 抽象modify 对象
    modify: (args,next)->
        @.get args, (err,result) ->
            if err
                next err, null
            else
                if result.length > 0
                    try
                        if args.password is undefined
                           db.query "UPDATE user SET name = ?,motto = ? WHERE email = ?", [args.name,args.motto,result[0].email],(err,result) ->
                               throw err if err
                               # set password of args
                               next null, args
                        else
                           db.query "UPDATE user SET password = ?,email = ? WHERE email = ?", [args.password, args.email, result[0].email],(err,result) ->
                               throw err if err
                               # set password of args
                               next null, args
                    catch err
                        next err, null
module.exports = User

###
User.save = (info,next)->
  user = new User
  user.register info,next
User::register = (info,next)->
  self = @
  self.name = info.name
  self.email = info.email
  self.password = info.password
  self.save()
  next null,self

# check user
User.get = (user,next)->
  User.findOne {email:user.email},(err,dbUser)->
    return next err if err
    if not dbUser?
      next err,null
    else
      next err,dbUser
###
###
User.modify = (args,next)->
  User.findOne({email:args.email}).exec (err,user)->
    try
      if args.password is undefined
          user.name = args.name
          user.motto = args.motto
      else
          user.password = args.password
          user.email = args.email
      user.save()
      next null,user
    catch err
      next err,null
###
