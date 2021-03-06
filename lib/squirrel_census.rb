# ENVIRONMENT FILE

# load all the files we need to run our app
require_relative "squirrel_census/version"
require_relative 'squirrel_census/cli'
require_relative 'squirrel_census/squirrel_api'
require_relative 'squirrel_census/date'
require_relative 'squirrel_census/squirrel'

# dependencies
require 'pry'
require 'ruby_figlet'
require 'net/http'
require 'json'