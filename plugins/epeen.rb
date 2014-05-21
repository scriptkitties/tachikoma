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
      u = UserModel.select(:id, :nickname).filter(Sequel.ilike(:nickname, nick)).all
      s = UserStatModel.where(:user_id => u[0].id).all
      s[0].epeen += 1
      s[0].save

      m.reply "Epeen of #{u[0].nickname} is now #{s[0].epeen}"
    end
  end

  match(/shrink (\w+)/i, method: :shrink)
  def shrink(m, nick)
    c = UserModel.filter(Sequel.ilike(:nickname, nick)).count

    if c == 0
      m.reply "No"
    else
      u = UserModel.select(:id, :nickname).filter(Sequel.ilike(:nickname, nick)).all
      s = UserStatModel.where(:user_id => u[0].id).all
      s[0].epeen -= 1
      s[0].save

      m.reply "Epeen of #{u[0].nickname} is now #{s[0].epeen}"
    end
  end
end

