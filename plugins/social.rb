#!/usr/bin/env ruby

require "cinch"

class Social
  include Cinch::Plugin

  match(/^bye/i, method: :goodbye, use_prefix: false)
  def goodbye(m)
    m.reply "Goodbye, #{m.user.nick}"
  end

  match(/^hello$|^hi$/i, method: :hello, use_prefix: false)
  def hello(m)
    m.reply "Hello, #{m.user.nick}!"
  end
end

