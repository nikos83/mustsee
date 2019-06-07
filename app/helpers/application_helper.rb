# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success' then 'alert-success'
    when 'error' then 'alert-danger'
    when 'alert' then 'alert-warning'
    when 'notice' then 'alert-info'
    else
      'alert-info'
    end
  end

  def l_date(date)
    l date if date.present?
  end
end
