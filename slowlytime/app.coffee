
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")
ejs = require("ejs")
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
app.use app.router
app.use require("stylus").middleware(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "public"))

# development only
app.use express.errorHandler()  if "development" is app.get("env")
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

# rewrite routes

routes app
user app
