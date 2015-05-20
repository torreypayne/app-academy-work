module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req, @res = req, res
      @already_built_response = false
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      if !@already_built_response
        @res["Location"] = url
        @res.status = 302
        @already_built_response = true
      else
        raise Exception.new "Rendered twice!"
      end
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      if !@already_built_response
        @res.content_type = content_type
        @res.content_length = content.to_s.length
        @res.body = content
        @already_built_response = true
      else
        raise Exception.new "Rendered twice!"
      end
    end
  end
end
