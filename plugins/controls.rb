#!/usr/bin/env ruby

require "cinch"

class Controls
  include Cinch::Plugin

  set :prefix, /^!/

  match(/join (S+)/)
  def execute(m, channel)
    bot.join channel
  end

  # todo: invite - Let the bot invite someone (and give this nick +v when it joins)
  # todo: kick - Let the bot kick someone
  # todo: part - Leave current channel

  match "quit"
  def execute(m)
    bot.quit
  end
end

