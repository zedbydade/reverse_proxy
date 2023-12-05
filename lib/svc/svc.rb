# Main service for proxying logic.

class Svc
  attr_accessor :remote_addr, :client

  def initialize(remote_addr:, client:)
    @remote_addr = remote_addr
    @client = client
  end

  def self.log_request(req)
    referrer = req.headers['referrer']
    user_agent = req.headers['user-agent']

    "
    IP: #{remote_addr.ip}
    TIME: #{Time.now.strftime('%H:%M:%S:%Y')}
    METHOD: #{req.method}
    PATH: #{req.path}
    QUERY: #{req.path}
    VERSION: #{req.version}
    REFERRER: #{referrer}
    USER_AGENT: #{user_agent}
    "
  end
end
