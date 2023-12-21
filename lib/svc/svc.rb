# Main service for proxying logic.

class Svc
  attr_accessor :socket, :client

  def initialize(socket:, client:)
    @socket = socket
    @client = client
  end

  def service(req)
    path_and_query = req.uri.path + '?' + req.uri.query
    log_request(req, path_and_query)

    url = 'http://localhost:1111' + path_and_query
    client.request(req.verb, url)
  end

  private

  def log_request(req, path_and_query)
    referrer = req.headers['referrer']
    user_agent = req.headers['user-agent']
    puts "
    IP: #{client.peeraddr[3]}
    TIME: #{Time.now.strftime('%H:%M:%S:%Y')}
    METHOD: #{req.verb}
    PATH/QUERY: #{path_and_query}
    VERSION: #{req.version}
    REFERRER: #{referrer}
    USER_AGENT: #{user_agent}
    "
  end
end
