require 'net/http'

class Downloader

  def get(url, params = {})
    uri = URI(url)
    uri.query = URI.encode_www_form(params)
    
    res = Net::HTTP.get_response(uri)
    
    if res.kind_of?(Net::HTTPRedirection)  
      return self.get(redirect_url(res))
    end
    
    res.body
  end  
  
  private
  
  def redirect_url(response)
    if response['location'].nil?
      response.body.match(/<a href=\"([^>]+)\">/i)[1]
    else
      response['location']
    end
  end
end