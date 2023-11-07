#!/usr/bin/ruby
require 'socket'
require 'openssl'

server = TCPServer.new('localhost', 2000) # Server bind to port 2000
context = OpenSSL::SSL::SSLContext.new
context.servername_cb = 'localhost:2000'
ssl_server = OpenSSL::SSL::SSLServer.new(server, context)

loop do
  p "Starting server: #{ssl_server.inspect}"
  client = ssl_server.accept # Wait for a client to connect
  p "With client: #{client.inspect}"
  client.write 'TU-TU-RU with TLS'
  client.close
end
