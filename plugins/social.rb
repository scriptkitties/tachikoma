#!/usr/bin/env ruby

require "cinch"

class Social
  include Cinch::Plugin

  match(/(.*)?african\-american[s]?(.*)?/, method: :nigger, use_prefix: false)
  match(/^hi|hello/, method: :hello, use_prefix: false)

  def hello(m)
    m.reply "Hi #{m.user.nick}!"
  end

  def nigger(m, before = "", after = "")
    #m.reply before+Format(:bold, "%s" % ["nigger"])+after
    if (m.params[1] =~ /^.*s$/)
      message = "niggers"
    else
      message = "a nigger"
    end

    m.reply message
  end
end

