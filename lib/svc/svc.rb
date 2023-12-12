# Main service for proxying logic.

class Svc
  attr_accessor :remote_addr, :client

  def initialize(remote_addr:, client:)
    @remote_addr = remote_addr
    @client = client
  end

  def service(req)
    log_request(req)

    url = 'http://localhost:1111' + req.uri.path + req.uri.query
    client.request(url)
  end
  private

  def log_request(req)
    referrer = req.headers['referrer']
    user_agent = req.headers['user-agent']
    path_and_query = req.uri.path + req.uri.query
    puts "
    IP: #{remote_addr.inspect_sockaddr}
    TIME: #{Time.now.strftime('%H:%M:%S:%Y')}
    METHOD: #{req.verb}
    PATH/QUERY: #{path_and_query}
    VERSION: #{req.version}
    REFERRER: #{referrer}
    USER_AGENT: #{user_agent}
    "
  end
end
