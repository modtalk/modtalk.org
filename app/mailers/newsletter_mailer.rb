class NewsletterMailer < ActionMailer::Base
	default :from => 'modtalk@modtalk.org'

	def subscribe_notification(name, email)
		@params = {:name => name, :email => email}
		@date = Time.now.utc

		headers 'X-Mailer' => 'Ruby'

		mail :to => email, :subject => 'Modtalk Mailing List Confirmation' do |format|
			format.text
		end
	end
end
