"use strict"

################
### REQUIRES ###
################

should  = require('should')
assert  = require("assert")
request = require("supertest")
request = request('http://localhost:3000')

#############
### TESTS ###
#############

describe "GET /", ->

  it "doit retourner un json et être une 200", (done) ->
    request.get("/").set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200, done)

describe "GET /trololol", ->

  it "doit retourner un json et être une 404", (done) ->
    request.get("/trololol").set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(404, done)
