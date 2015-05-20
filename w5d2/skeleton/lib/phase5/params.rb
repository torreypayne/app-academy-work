require 'uri'



module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params
      p @params
      parse_www_encoded_form(req.query_string) if req.query_string
      parse_www_encoded_form(req.body) if req.body
      p @params
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      hashes = www_encoded_form.split('&')
      data = hashes.map { |hash| parse_key(hash) }
      current = @params
      data.each do |array|
        val = array.pop
        last_key = array.last
        current = @params
        array.each_with_index do |key, idx|
          unless key == last_key
            current[key] = {} unless current.has_key?(key)
            current = current[key]
          else
            current[key] = val
            break
          end
        end
      end

      @params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      new_key = key.split(/\]\[|\[|\]|\=/).reject { |str| str.empty? }
      # unless new_key == key
      #   new_key.map { |el| parse_key(el) }
      # end

      # new_key
    end
  end
end
