#!/usr/bin/env ruby

require "cinch"

class Epeen
  include Cinch::Plugin

  match(/extend (\w+)/i, method: :extend)
  def extend(m, arg)
    m.reply "Extending #{arg}"
  end

  match(/shrink (\w+)/i, method: :shrink)
  def shrink(m, arg)
    m.reply "Shrinking #{arg}"
  end
end

