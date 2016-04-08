module ApplicationHelper
  def active_page?(action)
    action_name == action
  end
end
