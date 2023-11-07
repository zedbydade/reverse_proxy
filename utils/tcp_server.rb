#!/usr/bin/ruby

require 'socket'

server = TCPServer.new('localhost', 2000) # Server bind to port 2000
loop do
  p "Starting server: #{server.inspect}"
  client = server.accept # Wait for a client to connect
  p "With client: #{client.inspect}"
  client.write 'TU-TU-RU'
  client.close
end
