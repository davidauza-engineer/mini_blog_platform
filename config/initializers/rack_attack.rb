# frozen_string_literal: true

class Rack::Attack
  # Throttle all requests by IP (60rpm)
  throttle("req/ip", limit: 60, period: 1.minute) do |req|
    req.ip
  end

  # Throttle login attempts by IP address
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    req.path == "/users/sign_in" && req.post? ? req.ip : nil
  end

  # Customize the response for throttled requests
  self.throttled_responder = lambda do |request|
    now = Time.now.utc
    match_data = request.env["rack.attack.match_data"]

    headers = {
      "Content-Type" => "application/json",
      "Retry-After" => match_data[:period].to_s,
      "X-RateLimit-Limit" => match_data[:limit].to_s,
      "X-RateLimit-Remaining" => "0",
      "X-RateLimit-Reset" => (now + match_data[:period]).to_s
    }

    [ 429, headers, [ { error: "Rate limit exceeded. Try again in #{match_data[:period]} seconds." }.to_json ] ]
  end
end
