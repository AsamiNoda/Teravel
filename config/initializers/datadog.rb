# config/initializers/datadog.rb

Datadog.configure do |c|
  c.env = 'staging-1'
  c.service = 'login-auth'
  c.sampling.default_rate = 1.0

  c.use :rails
end

