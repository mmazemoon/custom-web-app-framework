require 'uri'

module Phase5
  class Params
    # gives our params hash functionality.
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params
        parse_www_encoded_form(req.query_string)
        parse_www_encoded_form(req.body)
    end

    def [](key)
      @params[key.to_sym]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street] = main & user[address][zip] = 89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      decoded_array = decode_www_form(www_encode_form) # => returns an array of [ k[k][k][k], v]  pairs  [[‘a’, ‘1’], [‘a’, ‘2’], [‘b’, ‘3’]]
      @params
      decoded_array.each do |pair|
        keys = parse_key(pair[0])
        val = pair[1]
        current = @params
        keys.each.with_index do |key, i|
          if i == keys.length - 1
              current[key] = val
          else
            current[key] ||= { }
            current = current[key]
          end
        end
      end
      @params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end

  end
end

# Decode URL-encoded form data from given str.
