require 'openssl'

ssl_context = OpenSSL::SSL::SSLContext.new
socket = TCPSocket.open('localhost', 2000)
ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
ssl_socket.sync_close = true
ssl_socket.connect
p ssl_socket.gets
