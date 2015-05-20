require 'byebug'
require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      query = req.cookies.find{ |cookie| cookie.name == "_rails_lite_app" }
      if query.nil?
        @cookie = {}
      else
        @cookie = JSON.parse(query.value)   # parse into ruby hash
      end
    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    # adds a cookie to the response (it had location & status before from redirect)
    def store_session(res)
      baked = WEBrick::Cookie.new("_rails_lite_app", @cookie.to_json)
      res.cookies << baked
    end
  end
end
