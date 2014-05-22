#!/usr/bin/env ruby

require "cinch"

class Epeen
  include Cinch::Plugin

  def mutatePeen(m, nick, value)
  def setPeen(m, nick, value)
    adminArray = ['tyiwi', 'Beagon', 'tyil']
    if adminArray.include? m.user.nick
      c = UserModel.filter(Sequel.ilike(:nickname, nick)).count
      if c == 0
        return false
      end
      u = UserModel.select(:id, :nickname).filter(Sequel.ilike(:nickname, nick)).all
      s = UserStatModel.where(:user_id => u[0].id).all
      s[0].epeen = value
      s[0].save
      m.reply "#{nick}'s E-peen has been changed to #{s[0].epeen}"
    end
    return true
  end
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

  match(/chop (\w+)/i, method: :chop)
  def chop(m, nick)
    setPeen(m, nick, 0)
  end

  match(/changepeen (\w+) (.*)/i, method: :change)
  def change(m, nick, value)
    setPeen(m, nick, value)
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

