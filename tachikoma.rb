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
    c.server          = "irc.rizon.net"
    c.port            = 6697
    c.nick            = "tachikoma"
    c.user            = "cinch"
    c.realname        = "Tachikoma"
    c.channels        = ["#scriptkitties"]

    # SSL config
    c.ssl.client_cert = "/srv/tachikoma/cert/rizon.pem"
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
end

# Start the bot
bot.start

