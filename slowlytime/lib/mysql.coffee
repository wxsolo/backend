mysql = require 'mysql'
connection = mysql.createConnection
    host: 'localhost'
    user: 'root'
    password: ''
    database: 'slowlytime'

module.exports = connection
