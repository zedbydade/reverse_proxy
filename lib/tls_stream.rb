class TlsStream 
  # stream; TCP connection 
  # config; keys, certifications and TLS security things
  attr_accessor :stream, :config

  def initialize(stream:, config:)
    @stream = stream 
    @config = config
  end

  def call 
    remote_addr = stream.remote_host 
    accept = OpenSSL::SSL::SSLSocket.new(stream, config)
    { remote_addr:, accept: }
  end 
end
