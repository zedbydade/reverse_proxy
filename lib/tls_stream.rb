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
    remote_addr = stream.remote_host
    # SSL_CONTEXT WILL BE FRONZEN HERE
    p remote_addr
    accept = OpenSSL::SSL::SSLSocket.new(stream, config).accept
    { remote_addr:, accept: }
  end
end
