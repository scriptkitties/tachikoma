#!/usr/bin/env ruby

require "cinch"

class Controls
  include Cinch::Plugin

  set :prefix, /^!/

  match(/join (S+)/)
  def execute(m, channel)
    bot.join channel
  end

  match "quit"
  def execute(m)
    bot.quit
  end
end

