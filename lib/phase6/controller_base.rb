require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase

    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(name)
      send(name)  # self.to_s, or controller.to_s
      render(name) unless already_built_response?
    end
  end
end

=begin

Add a method ControllerBase#invoke_action(action_name)
use send to call the appropriate action (like index or show)
check to see if a template was rendered; if not call render in invoke_action.

=end
