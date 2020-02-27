# ENVIRONMENT FILE

# load all the files we need to run our app
require "squirrel_census/version"
require_relative 'squirrel_census/cli'
require_relative 'squirrel_census/scraper'
require_relative 'squirrel_census/date'
require_relative 'squirrel_census/squirrel'
require_relative 'squirrel_census/spacer'

# dependencies
require 'pry'
require 'ruby_figlet'
require 'net/http'
require 'json'