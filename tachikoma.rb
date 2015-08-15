#!/usr/bin/env ruby

# require our gems
require 'cinch'
require 'yaml'

# calculate the base dir of the application
basedir = File.expand_path(File.dirname(__FILE__))

# require our plugins
Dir[basedir+'/plugins/*.rb'].each do |plugin|
  require plugin
end

# create the bot instance
bot = Cinch::Bot.new do
  configure do |c|
    # get the irc config
    botConf = YAML.load_file(basedir+'/conf/irc.yaml')

    # server config
    c.server          = botConf['server']['host']
    c.password        = botConf['server']['password']
    c.port            = botConf['server']['port']
    c.nick            = botConf['bot']['nick']
    c.user            = botConf['bot']['user']
    c.realname        = botConf['bot']['realname']
    c.channels        = botConf['server']['channels']

    # SSL config
    # @todo: properly setup certificate usage
    c.ssl.use         = botConf['server']['ssl']['use']

    # loaded plugins
    # @todo: define this in the configfiles?
    c.plugins.plugins = [
#      Controls,
#      Info,
#      Social
    ]
  end

  trap "SIGINT" do
    # exit cleanly
    bot.quit "Caught SIGINT"
  end

  trap "SIGTERM" do
    # exit cleanly
    bot.quit "Caught SIGTERM"
  end
end

# start the bot
bot.start

