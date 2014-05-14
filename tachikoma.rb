#!/usr/bin/env ruby

# Require the framework
require 'cinch'

# Require all of our plugins
Dir[File.dirname(__FILE__) + '/plugins/*.rb'].each {|file| require file}

# Create the bot instance
bot = Cinch::Bot.new do
  configure do |c|
    # Server config
    c.server          = "irc.rizon.net"
    c.port            = 6667
    c.nick            = "tachikoma"
    c.user            = "cinch"
    c.realname        = "Tachikoma"
    c.channels        = ["#scriptkitties"]

    # SSL config
#    c.ssl.ca_path     = "/etc/ssl/certs/"
#    c.ssl.client_cert = ""
#    c.ssl.use         = true
#    c.ssl.verify      = true

    # Loaded plugins
    c.plugins.plugins = [
      Controls,
      Social
    ]
  end

  trap "SIGINT" do
    # Exit cleanly
    bot.quit
  end

  trap "SIGTERM" do
    # Exit cleanly
    bot.quit
  end
end

# Start the bot
bot.start

