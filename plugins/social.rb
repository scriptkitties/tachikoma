#!/usr/bin/env ruby

require "cinch"

class Social
  include Cinch::Plugin

  match(/(.*)?(african\-american[s]?)(.*)?/, method: :nigger, use_prefix: false)
  match(/^(ha?i|hello)[\.\!\?]?$/i, method: :hello, use_prefix: false)

  def hello(m)
    m.reply "Hi #{m.user.nick}!"
  end

  def nigger(m, before = "", hit = "", after = "")
    if hit =~ /^african\-americans$/
      message = "niggers"
    end

    if hit =~ /^african\-american$/
      message = "nigger"

      if before =~ /^(.*)an $/
        before  = before[0..-4]
        message = "a "+message
      end
    end

    m.reply before+Format(:bold, "%s" % [message])+after
  end
end

