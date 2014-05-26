#!/usr/bin/env ruby

require "cinch"
class Epeen
  include Cinch::Plugin

  def calcSize(epeen)
    i = 0

    while i < (Math.sqrt(epeen.abs) / 2)
      i += 1
    end

    return peen
  end

  def drawBoob(nick, epeen, size)
    size = size / 2
    fill = " " * size

    if epeen > 0
      m.reply "E-boobs of #{nick} are now (#{fill}.#{fill})(#{fill}.#{fill}) (#{epeen})"
    elsif epeen == 0
      m.reply "E-boobs of #{nick} are now . . (#{epeen})"

      if rand(100) <= 5
        m.action_reply("thinks that #{nick} is a pretty nice flatchest.")
      end
    else
      m.reply "#{nick} has no E-boobs. (#{epeen})"
    end
  end

  def drawPeen(nick, epeen, size)
    fill = "=" * size

    if epeen >= 0
      m.reply "E-peen of #{nick} is now 8#{fill}D (#{epeen})"
    else
      m.reply "#{nick} has an E-vagoo {(#{fill})} (#{epeen})"
    end
  end

  def mutatePeen(m, nick, value, art = "epeen") 
    if nick.downcase == m.user.nick.downcase
      return false
    end

    # Set own nick if no nick was given
    if nick == ""
      nick = m.user.nick;
    end

    # Check if we have this user in the database
    c = UserModel.filter(Sequel.ilike(:nickname, nick)).count

    if c == 0
      return false
    end

    # Select the user's stats
    u = UserModel.select(:id, :nickname).filter(Sequel.ilike(:nickname, nick)).all
    s = UserStatModel.where(:user_id => u[0].id).all

    # Mutate epeen
    s[0].epeen += value
    s[0].save

    # Draw epeen
    case art
    when "epeen"
      drawPeen(m, u[0].nickname, s[0].epeen, calcSize(s[0].epeen))
    when "eboob"
      drawBoob(m, u[0].nickname, s[0].epeen, calcSize(s[0].epeen))
    end

    return true
  end

  match(/chop (\w+)/i, method: :chop)
  def chop(m, nick)
    setPeen(m, nick, 0)
  end

  match(/epeen$/i, method: :check)
  match(/epeen (\w+)/i, method: :check)
  def check(m, nick = "")
    mutatePeen(m, nick, 0)
  end

  match(/eboob$/i, method: :eboob)
  match(/eboob (\w+)/i, method: :eboob)
  def eboob(m, nick = "")
    mutatePeen(m, nick, 0, "eboob")
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

