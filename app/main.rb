require "dotenv/load"
require_relative "short_io_service"
require_relative "twilio_service"

# instantiate a short.io object
shortIO = ShortUrlService.new("42ni.short.gy", ENV["SHORT_API_KEY"])
shortIO.create_short_url("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
short_url = shortIO.short_url

# instantiate a Twilio object
twilio = TwilioService.new(ENV["API_KEY_SID"], ENV["API_KEY_SECRET"], ENV["ACCOUNT_SID"])
params = {
  From: ENV["FROM_PHONE"],
  Body: "The cake is a lie - ",
  To: ENV["TO_PHONE"],
  URL: short_url
}

# send the SMS!
twilio.send_sms(params)
