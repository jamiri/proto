require "sinatra"
require 'bundler'
require "./db/ar_config"
require "./app"

Bundler.require

run Main.new

