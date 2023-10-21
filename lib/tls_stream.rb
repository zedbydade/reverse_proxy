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
    # WARNING
    # SSL_CONTEXT WILL BE FRONZEN HERE
    accept = OpenSSL::SSL::SSLSocket.new(stream, config).connect
    { remote_addr:, accept: }
  end
end
