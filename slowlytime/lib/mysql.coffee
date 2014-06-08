setting = require '../setting'
mysql = require 'mysql'

mysqlPool = null

initMysql = () ->
    mysqlPool = mysql.createPool setting.mysql

exports.query = (sql, params, next) ->

    initMysql() if not mysqlPool
    next 'sql is null', null if not sql
    mysqlPool.getConnection (err, connection) ->
        throw err if err
        connection.query sql, params, (err, rows)->
            connection.release()
            return next err, rows
