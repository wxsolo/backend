
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
people = require("./routes/people")
book = require("./routes/book")
contact = require("./routes/contact")
http = require("http")
path = require("path")
ejs = require("ejs")
log4js = require("log4js")
app = express()
ejs.open = "{{"
ejs.close = "}}"
# all environments
app.set "port", process.env.PORT or 4000
app.set "views", path.join(__dirname, "views")
app.set "view engine", "ejs"
app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session({secret: '1234567890QWERTY'});
app.use app.router
app.use require("stylus").middleware(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "public"))
# development only
app.use express.errorHandler()  if "development" is app.get("env")

logger = log4js.getLogger('normal');
logger.setLevel('INFO');

log4js.configure
  appenders:[    
    type: 'console'
    type: 'file'
    filename: 'logs/access.log'
    maxLogSize: 102400000,      
    backups:4,      
    category:'normal'     
    ]
  replaceConsole: true

app.use log4js.connectLogger(logger, {level:'auto', format:':method :url'})
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

# rewrite routes

routes app
user app
people app
book app
contact app
