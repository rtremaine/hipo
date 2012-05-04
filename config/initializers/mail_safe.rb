if defined?(MailSafe::Config)
  MailSafe::Config.internal_address_definition = /.*@my-domain\.com/i
  MailSafe::Config.replacement_address = 'thealey@gmail.com'
end
