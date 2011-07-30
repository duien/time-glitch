Rails.application.config.middleware.use OmniAuth::Builder do
  provider :glitch, ENV['GLITCH_API_KEY'], ENV['GLITCH_API_SECRET'],
    :scope => 'read'
end
