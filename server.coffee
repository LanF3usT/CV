"use strict"

################
### REQUIRES ###
################

require "colors"
express   = require("express")
http      = require("http")
morgan    = require("morgan")
util      = require("util")
moment    = require("moment")
md5       = require("MD5")
fs        = require("fs")
data      = JSON.parse(fs.readFileSync(__dirname + "/data.json", "utf8"))

#################
### VARIABLES ###
#################

app     = express()
server  = http.createServer(app)
devMode = "development" == app.get("env")

######################
### CONFIGURATIONS ###
######################

app.set("port", process.env.PORT || 3000)
app.set("view engine", "jade")

moment.locale("fr")
app.locals.moment = moment

# Passe le dossier CSS en static
app.use(express.static(__dirname + "/css"))

# Log en mode dev ou common
app.use morgan(if devMode then "dev" else "common")

# Voir le HTML indenté dans la source
app.locals.pretty = devMode

##############
### ROUTES ###
##############

app.get "/", (req, res) ->
  res.render "index",
    title: "CV de #{data["prenom"]} #{data["nom"]}"
    gravatar_hash: md5(data["email"])
    data: data
    competences: data["competences"]
    experiences: data["experiences"]
    formations:  data["formations"]
    interets:    data["interets"]

app.get "*", (req, res) ->
  res.status(404).json { error: "404 : page non trouvée !", created_at: moment() }

###############
### SERVEUR ###
###############

server.listen app.get("port"), ->
  msg = util.format "✔︎ Démarrage du serveur sur http://localhost:%d/", app.get("port")
  console.log msg.green
