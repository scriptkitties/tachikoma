#!/usr/bin/env ruby

# Require dependencies
require "cinch"
require "json"
require "sequel"

# Require all of our plugins
Dir[File.dirname(__FILE__)+"/plugins/*.rb"].each {|file| require file}

# Read the configuration file
conf = JSON.parse(IO.read(File.dirname(__FILE__)+"/conf/tachikoma.json"));

# Create all databases
$DB = Hash.new

conf["databases"].each do |db|
  # Generate the DNS
  dsn = db[1]["driver"]+"://"+db[1]["username"]+":"+db[1]["password"]+"@"+db[1]["host"]+"/"+db[1]["db"]

  # Create the dabatase connection
  $DB[db[0]] = Sequel.connect(dsn)
end

# Now that we got our database connections, we can also load our models
Dir[File.dirname(__FILE__)+"/models/*.rb"].each {|file| require file}

# Create the bot instance
bot = Cinch::Bot.new do
  configure do |c|
    # Server config
    # @todo: Get these configs from the database
    c.server          = "irc.rizon.net"
    c.local_host      = "37.34.59.228"
    c.port            = 6697
    c.nick            = "tachikoma"
    c.user            = "cinch"
    c.realname        = "Tachikoma"
    c.channels        = ["#scriptkitties"]

    # SSL config
    c.ssl.client_cert = conf["cert"]
    c.ssl.use         = true

    # Loaded plugins
    c.plugins.plugins = [
      Controls,
      Epeen,
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

  on :leaving do |m, user|
    if m.channel?
      reply = "Bye #{user}! We're going to miss you!"
      if rand(10) <= 2
        reply += " (Probably not though)"
      end
      m.reply reply
    end
  end

end

# Start the bot
bot.start

