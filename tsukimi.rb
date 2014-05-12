#!/usr/bin/env ruby

# Require the framework
require 'cinch'

# Require all of our plugins
Dir[File.dirname(__FILE__) + '/plugins/*.rb'].each {|file| require file}

# Create the bot instance
bot = Cinch::Bot.new do
	configure do |c|
		c.server          = "irc.rizon.net"
		c.channels        = ["#scriptkitties"]
		c.nick            = "not-a-bot"
		c.plugins.plugins = [Social, Controls]
	end

	trap "SIGINT" do
		bot.quit("Whyyyyyyyy")
	end

	trap "SIGTERM" do
		bot.quit("It... hurts...")
	end
end

# Start the bot
bot.start
