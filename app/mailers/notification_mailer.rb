class NotificationMailer < ApplicationMailer
  def notification_mail(picture)
    @picture = picture

    mail to: "#{@picture.user.email}", subject: "投稿完了通知"
  end
end
