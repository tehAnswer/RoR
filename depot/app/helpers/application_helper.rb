module ApplicationHelper

  def notice_color(notice)
    if notice
      type = type_notice(notice)
      message = message_notice(type, notice)
  		div_tag_head = "<div class=\"alert alert-#{type} alert-dismissable\">"
  		cross_button = "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>"
  		notice_tag = div_tag_head + cross_button + message + "</div>"
  		notice_tag.to_s.html_safe
  	end
  end

  def type_notice(notice)
    downcased = notice.downcase
    if downcased.include? 'error' or downcased.include? 'invalid'
      return 'danger'
    elsif downcased.include? 'thanks' or downcased.include? 'success'
      return 'success'
    elsif downcased.include? 'hey'
      return 'warning'
    else 
      return 'info'
    end 
  end 

  def message_notice(type, notice)
    messages = {
      :danger => 'Oops, something wrong happened',
      :success => 'Done',
      :warning => 'Hey, be careful',
      :info => 'News, news'
    }

    "<strong>#{messages[type.to_sym]}!</strong> #{notice}"
end



private :type_notice, :message_notice
end 