module SimpleMattermost
  class Hook

    attr_accessor :hook_url, :default_user_name, :default_user_icon

    def initialize(url = nil)
      @hook_url = url || ENV['MATTERMOST_WEBHOOK_URL']
      @client   = HTTPClient.new
      @default_user_name = 'bot'
      @default_icon_url  = ''
    end

    def configure
      yield(self)
    end

    def post(text, user_name = nil, icon_url = nil)
      user_name ||= @default_user_name
      icon_url  ||= @default_icon_url

      params = { username: user_name, icon_url: icon_url, text: text }.to_json
      res    = @client.post(@hook_url, "payload=#{params}")
      return raise "post error\nparams: #{params}" unless res.status == 200
      true
    end
  end
end
