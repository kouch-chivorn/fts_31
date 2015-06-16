if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = {url: ENV["REDISGOTO_URL"]}
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: ENV["REDISGOTO_URL"]}
  end
end
