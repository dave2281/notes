Recaptcha.configure do |config|
  config.site_key = ENV['RECAPTCHA_NOTES_PUBLIC_KEY']
  config.secret_key = ENV['RECAPTCHA_NOTES_PRIVATE_KEY']
end