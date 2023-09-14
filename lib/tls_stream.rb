class TlsStream 
  # stream; TCP connection 
  # config; keys, certifications and TLS security things
  attr_accessor :stream, :config

  def initialize(stream:, config:)
    @stream = stream 
    @config = config
  end

  def call 
  end 
end
