require_relative 'svc/svc'
require_relative 'tls/tls'
require_relative 'redirect/redirect'
require_relative 'cert/cert'

context = Cert.load
server = TCPServer.new('localhost', 1111)
ssl_server = OpenSSL::SSL::SSLServer.new(server, context)

incoming = TCPSocket.open('localhost', 8443)
remote_addr = Addrinfo.tcp("localhost", 2000)
tls_acceptor = TlsStream.new(incoming, context)

client = HTTP::Request.new({verb: :get, uri: "https://placewaifu.com/image/500?a=a"})

https_server = Svc.new(incoming, HTTP::Client.new).req(client)
http_server = Scv.new(incoming, HTTP::Client.new).req(Redirect.call(client))
