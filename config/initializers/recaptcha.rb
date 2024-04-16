Recaptcha.configure do |config|
  config.public_key = ENV['RECAPTCHA_NOTES_PUBLIC_KEY']
  config.private_key = ENV['RECAPTCHA_NOTES_PRIVATE_KEY']
end