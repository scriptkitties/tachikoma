#!/usr/bin/env ruby

require "cinch"

class DuckDuckGo
  include Cinch::Plugin

  match(/ddg/)
  def execute(m)
    # Search DuckDuckGo, return first result
  end
end

