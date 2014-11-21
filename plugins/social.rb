#!/usr/bin/env ruby

require "cinch"

class Social
  include Cinch::Plugin

  match(/(.*)?african\-american(.*)?/, method: :nigger, use_prefix: false)
  match(/^hi|hello/, method: :hello, use_prefix: false)

  def hello(m)
    m.reply "Hi #{m.user.nick}!"
  end

  def nigger(m, before = "", after = "")
    m.reply before+Format(:bold, "%s" % ["nigger"])+after
  end
end

