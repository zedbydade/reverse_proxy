require 'http'

class Redirect 
  def self.call(req) 
    host = req.host
    if host
      path_and_query = req.uri.path + '?' + req.uri.query
      location = "https://#{host}:8443#{path_and_query}"
      HTTP::Response.new({status: 308, request: req, version: :https, connection: false, headers: {location: location}}) 
    else 
      HTTP::Response.new({status: 404, request: req, version: :https, connection: false}) 
    end
  end
end
