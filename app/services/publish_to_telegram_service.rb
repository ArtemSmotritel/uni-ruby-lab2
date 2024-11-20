class PublishToTelegramService
  def initialize(article)
    @article = article
  end

  def call
    message = "New Blog Post: \n#{@article.title}\n#{@article.body.truncate(100)}\nRead more: #{Rails.application.routes.url_helpers.article_url(@article, host: ENV['APP_HOST'])}"
    begin
      TELEGRAM_BOT_CLIENT.api.send_message(chat_id: ENV['TELEGRAM_CHANNEL_ID'], text: message)
    rescue Telegram::Bot::Exceptions::ResponseError => e
      Rails.logger.error("Failed to send message to Telegram: #{e.message}")
    end
  end
end
