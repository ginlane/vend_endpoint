require 'rubygems'
require 'bundler'
ENV['ENDPOINT_KEY'] = "5329f763b439577c52013fd0"
Bundler.require(:default)
require "./vend_endpoint"
run VendEndpoint