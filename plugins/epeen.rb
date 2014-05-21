#!/usr/bin/env ruby

require "cinch"

class Epeen
  include Cinch::Plugin

  match(/text/i, method: :test)
  def test(m)
    result = $DB["s"]["select nickname from users where id=1"]
    nicks  = result.map(:nickname)

    m.reply "Testing something: "+nicks[0]
  end

  match(/extend (\w+)/i, method: :extend)
  def extend(m, arg)
    m.reply "Extending #{arg}"
  end

  match(/shrink (\w+)/i, method: :shrink)
  def shrink(m, arg)
    m.reply "Shrinking #{arg}"
  end
end

