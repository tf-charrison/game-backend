Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Replace '*' with your Flutter app's URL if you want to restrict it
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end
