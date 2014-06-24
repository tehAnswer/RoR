class Notifier < ActionMailer::Base
 
  def contact(recipient)
    @recipient = recipient

    mail(to: @recipient, from: "nicki@minaj.com") do |format|
      format.text
      format.html
    end
  end
  
end