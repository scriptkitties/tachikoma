#!/usr/bin/env ruby

require "cinch"

class Epeen
  include Cinch::Plugin

  match(/extend (\w+)/i, method: :extend)
  def extend(m, nick)
    c = UserModel.filter(Sequel.ilike(:nickname, nick)).count

	if c == 0
	  m.reply "No"
	else
	  u = UserModel.filter(Sequel.ilike(:nickname, nick)).get
	  m.reply "Extending #{u[0].nickname}"
	end
  end

  match(/shrink (\w+)/i, method: :shrink)
  def shrink(m, nick)
    m.reply "Shrinking #{nick}"
  end
end

