#!/usr/bin/env ruby

require "cinch"

class Controls
  include Cinch::Plugin
  set :prefix, /^!/

  match(/ban (\w+)/i, method: :ban)
  match(/deop (\w+)/i, method: :deop)
  match(/devoice (\w+)/i, method: :devoice)
  match(/emote (.*)/i, method: :emote)
  match(/invite (\w+)/i, method: :invite)
  match(/join \#(\w+)/i, method: :join)
  match(/kick (\w+) (.*)/i, method: :kick)
  match(/kick (\w+)/i, method: :kick)
  match(/op (\w+)/i, method: :op)
  match(/part (\w+)/i, method: :part)
  match(/quit/, method: :quit)
  match(/say (.*)/i, method: :say)
  match(/unban (\w+)/i, method: :unban)
  match(/voice (\w+)/i, method: :voice)

  def join(m, channel)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
      bot.join "#"+channel
    end
  end

  def say(m, text)
    adminArray = ['tyiwi', 'Beagon', 'tyil', 'haruhai']

    if adminArray.include? m.user.nick
      m.reply text
    end
  end

  def emote(m, text)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
      m.action_reply text
    end
  end

  def part(m, channel)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
      bot.part channel
    end
  end

  def invite(m, user)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
      m.channel.invite user
    end
  end

  def voice(m, user)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
      m.channel.voice user
    end
  end

  def devoice(m, user)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
     m.channel.devoice user
    end
  end

  def op(m, user)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
     m.channel.op user
    end
  end

  def deop(m, user)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
     m.channel.deop user
    end
  end

  def ban(m, user)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
     m.channel.ban(user)
    end
  end

  def unban(m, user)
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
     m.channel.unban(user)
    end
  end

  def kick(m, user, reason = "Because fuck you.")
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
      m.channel.kick(user, reason)
    end
  end

  def quit(m, message="")
    adminArray = ['tyiwi', 'Beagon', 'tyil']

    if adminArray.include? m.user.nick
      bot.quit message
    end
  end
end
