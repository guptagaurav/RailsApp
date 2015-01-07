OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, ENV['YKRsiung74vWNRbDOCJj5uXS0'],    ENV['24OR2TlYdWKvDi8OhzD3OajUEvwAq8JgVsKZlRgphHtPUCFLB6']
end
