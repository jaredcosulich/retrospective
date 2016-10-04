Recaptcha.configure do |config|
  config.public_key  = '6LewUQgUAAAAAHFNf2B8TcfqMDOOnNMxRjFReFjk'
  config.private_key = ENV['GRECAPTCHA_SECRET']
end
