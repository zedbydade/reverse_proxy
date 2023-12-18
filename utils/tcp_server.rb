#!/usr/bin/ruby

require 'socket'
server = TCPServer.new('localhost', 1111) # Server bind to port 2000
loop do
  p "Starting server: #{server.inspect}"
  client = server.accept # Wait for a client to connect
  p "With client: #{client.inspect}"

  response = "HTTP/1.1 200 OK\r\n" +
    "Content-Type: text/plain\r\n" +
    "Connection: close\r\n" +
    "\r\n" +
    "TU-TU-RU!"

  client.puts(response)
  client.close
end
