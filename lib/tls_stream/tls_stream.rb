require 'openssl'

class TlsStream
  # stream; TCP connection
  # config; keys, certifications and TLS security things(SSLContext)
  attr_accessor :stream, :config

  def initialize(stream:, config:)
    @stream = stream
    @config = config
  end

  def connect
    remote_addr = stream.remote_address
    # SSL_CONTEXT WILL BE FRONZEN HERE
    p remote_addr
    ssl_socket = OpenSSL::SSL::SSLSocket.new(stream, config)
    ssl_socket.sync_close = true
    ssl_socket.connect
    { remote_addr:, ssl_socket: }
  end

  def self.read(ssl_socket)
    ssl_socket.read(3000)
  end

  def self.write(ssl_socket)
    # I need to find the difference between write and puts
    ssl_socket.write("Write with TLS")
  end
end
