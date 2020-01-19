class NotificationMailer < ApplicationMailer
  def notification_mail(feed)
    @feed = feed
    
    mail to: "#{@feed.user.email}", subject: "投稿完了通知"
  end
end
