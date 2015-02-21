class NewsletterController < ApplicationController
  def subscribe
    @to_email = params[:email]
    NewsletterMailer.subscribe_notify(@to_email).deliver
  end
end
