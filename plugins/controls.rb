#!/usr/bin/env ruby

require "cinch"

class Controls
  include Cinch::Plugin
  set :prefix, /^!/

  match(/join (\w+)/i, method: :join)
  def join(m, channel)
    adminArray = ['tyiwi', 'Beagon', 'tyil']
    if adminArray.include? m.user.nick
     channelAppend = "#"
     channelAppend += channel
     bot.join channelAppend
   end
  end

  # todo: kick - Let the bot kick someone
  match(/say (.*)/i, method: :say)
  def say(m, text)
    adminArray = ['tyiwi', 'Beagon', 'tyil']
    if adminArray.include? m.user.nick
     m.reply text
   end
  end

  match(/emote (.*)/i, method: :emote)
  def emote(m, text)
    adminArray = ['tyiwi', 'Beagon', 'tyil']
    if adminArray.include? m.user.nick
     m.action_reply text
   end
  end

  match(/part (\w+)/i, method: :part)
  def part(m, channel)
    adminArray = ['tyiwi', 'Beagon', 'tyil']
    if adminArray.include? m.user.nick
     channelAppend = "#"
     channelAppend += channel
     bot.part channelAppend
   end
  end

  match(/invite (\w+)/i, method: :invite)
  def invite(m, user)
    adminArray = ['tyiwi', 'Beagon', 'tyil']
    if adminArray.include? m.user.nick
     m.channel.invite user
   end
  end

  match "quit"
  def execute(m)
    bot.quit
  end
end