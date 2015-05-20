require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      if !@already_built_response
        @session["Location"] = url
        @session["Status"] = 302
        @already_built_response = true
        @session.store_session(@res)
      else
        raise Exception.new "Rendered twice!"
      end
    end

    # def redirect_to(url)
    #   if !@already_built_response
    #     @res["Location"] = url
    #     @res.status = 302
    #     @already_built_response = true
    #   else
    #     raise Exception.new "Rendered twice!"
    #   end
    # end

    def render_content(content, content_type)
      if !@already_built_response
        @session["Content Type"] = content_type
        @session["Content Length"] = content.to_s.length
        @session["Body"] = content
        @already_built_response = true
        @session.store_session(@res)
      else
        raise Exception.new "Rendered twice!"
      end
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(@req)
    end
  end
end
