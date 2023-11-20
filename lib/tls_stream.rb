require 'openssl'

class TlsStream
  # stream; TCP connection
  # config; keys, certifications and TLS security things(SSLContext)
  attr_accessor :stream, :config

  def initialize(stream:, config:)
    @stream = stream
    @config = config
  end

  def call
    remote_addr = stream.remote_address
    # SSL_CONTEXT WILL BE FRONZEN HERE
    p remote_addr
    ssl_socket = OpenSSL::SSL::SSLSocket.new(stream, config)
    ssl_socket.sync_close = true
    ssl_socket.connect
    { remote_addr:, ssl_socket: }
  end
end
