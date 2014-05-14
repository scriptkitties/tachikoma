#!/usr/bin/env ruby

require "cinch"

class Social
  include Cinch::Plugin

  match(/^bye/, use_prefix: false)
  def execute(m)
    m.reply "Goodbye, #{m.user.nick}"
  end

  match(/^hello$|^hi$/, use_prefix: false)
  def execute(m)
    m.reply "Hello, #{m.user.nick}!"
  end
end

