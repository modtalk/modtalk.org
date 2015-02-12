class NewsletterMailer < ActionMailer::Base
  default from: 'Modtalk <modtalk@modtalk.org>'

  def subscribe_notify(email)
    @to_email = email
    @date = Time.now.utc
    layout = 'layouts/mailers/single_column'

    mail to: email, subject: 'Modtalk Mailing List Confirmation' do |format|
      format.html {
        render layout: layout
      }
      format.text {
        render layout: layout
      }
    end
  end
end
