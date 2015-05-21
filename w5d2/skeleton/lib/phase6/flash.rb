module Phase7

  class Flash

    def initialize(req)

      flash = req.cookies.select { |cookie| cookie.name == "_flash" }.first
      @now = JSON.parse(flash.value) if flash

      @flash_hash = {}
    end

    def [](key)
      @flash_hash[key] || @flash_hash["now"][key]
    end

    def []=(key, val)
      @flash_hash[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new("_flash", @flash_hash.to_json)
    end

    def now
      @now
    end
  end
end
