module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    coffeelint:
      app: ["*.coffee", "test/*.coffee"]
      options:
        configFile: "coffeelint.json"
    scsslint:
      app: ["css/*.scss"]
      options:
        config: ".scss-lint.yml"

  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-scss-lint"
  grunt.registerTask "default", ["coffeelint", "scsslint"]
