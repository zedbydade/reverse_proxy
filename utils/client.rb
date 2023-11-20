require 'openssl'

ssl_context = OpenSSL::SSL::SSLContext.new
ssl_context.min_version = OpenSSL::SSL::TLS1_1_VERSION
ssl_context.max_version = OpenSSL::SSL::TLS1_3_VERSION
ssl_context.ecdh_curves = 'X25519:P-256:P-224'
ssl_context.ciphers = [['TLS_AES_256_GCM_SHA384', 'TLSv1.3', 256, 256],
                       ['TLS_CHACHA20_POLY1305_SHA256', 'TLSv1.3', 256, 256], ['TLS_AES_128_GCM_SHA256', 'TLSv1.3', 128, 128], ['PSK-AES128-CBC-SHA256', 'TLSv1.0', 128, 128]]
socket = TCPSocket.open('localhost', 2000)
ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
ssl_socket.sync_close = true
ssl_socket.connect
p ssl_socket.gets
