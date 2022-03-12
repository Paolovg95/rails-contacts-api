class Rack::Attack

  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new # defaults to Rails.cache

  safelist('allow from localhost') do |req|
  # Requests are allowed if the return value is truthy
  '127.0.0.1' == req.ip || '::1' == req.ip
  end

  throttle("requests by ip", limit: 5, period: 2) do |request|
    request.ip
  end
end
