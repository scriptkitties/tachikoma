#!/usr/bin/env ruby

require "cinch"

class Controls
  include Cinch::Plugin

  set :prefix, /^!/

  match(/join (S+)/)
  def execute(m, channel)
    bot.join channel
  match(/join (\w+)/i, method: :join)
  def join(m, channel)
    adminArray = ['tyiwi', 'Beagon', 'tyil']
    if adminArray.include? m.user.nick
     channelAppend = "#"
     channelAppend += channel
     bot.join channelAppend
   end
  end

  # todo: invite - Let the bot invite someone (and give this nick +v when it joins)
  # todo: kick - Let the bot kick someone
  match(/part (\w+)/i, method: :part)
  def part(m, channel)
    adminArray = ['tyiwi', 'Beagon', 'tyil']
    if adminArray.include? m.user.nick
     channelAppend = "#"
     channelAppend += channel
     bot.part channelAppend
   end
  end

  match "quit"
  def execute(m)
    bot.quit
  end
end