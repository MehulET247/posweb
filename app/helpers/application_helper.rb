module ApplicationHelper
  def app_name
    Setting.first.present? && Setting.first.app_name.present? ? Setting.first.app_name : "POS WEB"
  end
end
