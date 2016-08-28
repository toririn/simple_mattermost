module SimpleMattermost
  class Client

    attr_accessor :host_url, :api_url, :team_name, :login_id, :passoword, :session_token

    def initialize(url = nil)
      @host_url = url    || ENV['MATTERMOST_HOST_URL']
      @api_url  = "#{@host_url}#{SimpleMattermost::API_PATH}"
      @client   = HTTPClient.new
    end

    def login(team = nil, login_id = nil, password = nil)
      # set params and validate
      @login_id  = login_id || ENV['MATTERMOST_LOGIN_ID']
      @password  = password || ENV['MATTERMOST_LOGIN_PASSWORD']
      @team_name = team     || ENV['MATTERMOST_TEAM_NAME']
      return raise 'login_id and password not set' unless @login_id && @password

      # post login api and responce valid
      login_url    = "#{@api_url}#{SimpleMattermost::LOGIN_PATH}"
      login_params = { name: @team_name, login_id: @login_id, password: @password }.to_json
      res = @client.post(login_url, login_params)
      return raise "login error\nlogin_url: #{login_url}\nlogin_params: #{login_params}" unless res.status == 200

      # set return token
      @session_token = res.header["Token"].first
      res
    end

    private

    def auth_headers
      [ [ 'Authorization', "Bearer #{@session_token}" ] ]
    end
  end
end
