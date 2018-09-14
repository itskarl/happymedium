# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'curb'
require 'json'
require 'uri'

run Rails.application
