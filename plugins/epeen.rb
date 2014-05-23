#!/usr/bin/env ruby

require "cinch"
class Epeen
  include Cinch::Plugin

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

  def mutatePeen(m, nick, value, art = "epeen") 
    if nick.downcase == m.user.nick.downcase
      return false
    end
    if nick == ""
      nick = m.user.nick;
    end

    c = UserModel.filter(Sequel.ilike(:nickname, nick)).count

    if c == 0
      return false
    end

    u = UserModel.select(:id, :nickname).filter(Sequel.ilike(:nickname, nick)).all
    s = UserStatModel.where(:user_id => u[0].id).all
    s[0].epeen += value
    s[0].save
    i = 0;
    peenArt = "";
    peen = "";

    case art
    when "epeen"
      while i < Math.sqrt(s[0].epeen.abs)
        if s[0].epeen < 0
          peen += " "
        else
          peen += "="
        end
        i += 1
      end

      if s[0].epeen >= 0
        m.reply "E-peen of #{u[0].nickname} is now 8#{peen}D (#{s[0].epeen})"
      else
        m.reply "#{u[0].nickname} has an E-vagoo {(#{peen})} (#{s[0].epeen})"
      end

    when "boob"

      while i < (Math.sqrt(s[0].epeen.abs) /2)
        peen += " "
        i += 1
      end

      if s[0].epeen > 0
        m.reply "E-boobs of #{u[0].nickname} are now (#{peen}.#{peen})(#{peen}.#{peen}) (#{s[0].epeen})"
        elsif s[0].epeen == 0
        m.reply "E-boobs of #{u[0].nickname} are now . . (#{s[0].epeen})"
        if rand(100) <= 5
        m.action_reply("thinks that #{u[0].nickname} has some lame ass titties.")
        end
        else
        m.reply "#{u[0].nickname} has no E-boobs. (#{s[0].epeen})"
      end
    end
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

  match(/epeen$/i, method: :check)
  match(/epeen (\w+)/i, method: :check)
  def check(m, nick = "")
    mutatePeen(m, nick, 0)
  end

  match(/eboob$/i, method: :eboob)
  match(/eboob (\w+)/i, method: :eboob)
  def eboob(m, nick = "")
    mutatePeen(m, nick, 0, "boob")
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

