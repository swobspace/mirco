#!/usr/bin/env ruby
# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'development'
require "#{File.dirname(__FILE__)}/../config/environment.rb"

Server.all.each do |srv|
  puts "### #{srv.name} ###"
  zip = ServerZip.new(srv, outfile: "./#{srv.hostname}.zip")
  zip.pack
end
