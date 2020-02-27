# ENVIRONMENT FILE
# load all the files we need to run our app

require "squirrel_census/version"
require_relative './squirrel_census/controller.rb'
require_relative './squirrel_census/date.rb'
require_relative './squirrel_census/squirrel.rb'

# dependencies
require 'pry'