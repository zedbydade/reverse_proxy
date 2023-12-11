#!/usr/bin/ruby
require 'socket'
require 'openssl'

def read_certificates(name) 
  File.binread name
end

public_key_raw = read_certificates('./utils/public.pem')
private_key_raw = read_certificates('./utils/private.pem')
certificate = OpenSSL::X509::Certificate.new(public_key_raw)
rsa_key = OpenSSL::PKey::RSA.new(private_key_raw)

server = TCPServer.new('localhost', 1111) # Server bind to port 1111
context = OpenSSL::SSL::SSLContext.new
context.add_certificate(certificate, rsa_key)
context.min_version = OpenSSL::SSL::TLS1_1_VERSION
context.max_version = OpenSSL::SSL::TLS1_3_VERSION
context.ecdh_curves = 'X25519:P-256:P-224'
context.ciphers = [['TLS_AES_256_GCM_SHA384', 'TLSv1.3', 256, 256],
                   ['TLS_CHACHA20_POLY1305_SHA256', 'TLSv1.3', 256, 256], ['TLS_AES_128_GCM_SHA256', 'TLSv1.3', 128, 128], ['PSK-AES128-CBC-SHA256', 'TLSv1.0', 128, 128]]
ssl_server = OpenSSL::SSL::SSLServer.new(server, context)

loop do
  p "Starting server: #{ssl_server.inspect}"
  client = ssl_server.accept # Wait for a client to connect
  p "With client: #{client.inspect}"
  p client.gets
  client.write 'TU-TU-RU with TLS'
  client.close
end
