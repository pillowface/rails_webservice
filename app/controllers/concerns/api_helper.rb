# app/controllers/concerns/api_helper.rb
module ApiHelper
  API_URL = "http://host20016.proxy.infralabs.cs.ui.ac.id/proxy".freeze
  ERROR = {error: "error", description: "deskripsi error"}.freeze

  def request_access_token
    url = "#{API_URL}/oauth/token"
    payload = {
      username: params[:username],
      password: params[:password],
      grant_type: "password",
      client_id: "nxXKbyS0qOZx8wKyK3lMn2X7beluD5s2",
      client_secret: "dhIxokd1BpzwPT5W59jMEtKzkR2BUoSE",
    }
    headers = { content_type: 'application/x-www-form-urlencoded' }
    begin
      response = RestClient.post url, payload, headers
      response_body = JSON.parse response.body
      return response_body["access_token"]
    rescue RestClient::Exception => e
      return nil
    end
  end

  def verify_access_token
    url = "#{API_URL}/oauth/resource"
    headers = { authorization: "#{request.headers["authorization"]}"}
    begin
      response = RestClient.get url, headers
      response_body = JSON.parse response.body
      raise RestClient::Exception if response_body["error"]
      return response_body
    rescue RestClient::Exception => e
      return nil
    end
  end

  def save_token(new_token)
    current_token = CurrentToken.first || CurrentToken.new
    current_token.access_token = new_token
    current_token.save!
  end
end