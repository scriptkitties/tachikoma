#!/usr/bin/env ruby

require "cinch"

class Info
  include Cinch::Plugin

  set :prefix, /^!/

  listen_to(:notice, method: :ctcp)

  match(/ver(?:sion)? (\S+)/i, method: :version)

  def ctcp(m)
    if m.ctcp?
      Channel("#scriptkitties").send "#{m.user}: #{m.ctcp_message}"
    end
  end

  def version(m, nick)
    User(nick).ctcp("VERSION")
  end
end

