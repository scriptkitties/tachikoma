#!/usr/bin/env ruby

require "cinch"

class Epeen
  include Cinch::Plugin

  def mutatePeen(m, nick, value)
    c = UserModel.filter(Sequel.ilike(:nickname, nick)).count

    if c == 0
      return false
    end

    u = UserModel.select(:id, :nickname).filter(Sequel.ilike(:nickname, nick)).all
    s = UserStatModel.where(:user_id => u[0].id).all
    s[0].epeen += value
    s[0].save

    m.reply "Epeen of #{u[0].nickname} is now #{s[0].epeen}"

    return true
  end

  match(/^\+(\w+)/i, method: :extend, use_prefix: false)
  match(/extend (\w+)/i, method: :extend)
  def extend(m, nick)
    mutatePeen(m, nick, 1)
  end

  match(/^\-(\w+)/i, method: :shrink, use_prefix: false)
  match(/shrink (\w+)/i, method: :shrink)
  def shrink(m, nick)
    mutatePeen(m, nick, -1)
  end
end

