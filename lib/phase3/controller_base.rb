require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'  # for string instances
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      controller_name = self.class.to_s.underscore
      absolute_path = File.absolute_path("views/#{controller_name}/#{template_name}.html.erb")
      template = File.read(absolute_path)
      evaluated_template_result = ERB.new(template).result(binding)
      render_content(evaluated_template_result, "text/html")
    end
  end
end
