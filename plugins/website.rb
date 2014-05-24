#!/usr/bin/env ruby

require "cinch"

class Social
  include Cinch::Plugin

  match(/\>\>(\d+)/, method: :post, use_prefix: false)
  def post(m, id)
    # @todo: Get data about the post and return a link + first ?? chars of post, maybe add img
  end

  match(/register (\w+) (\w+)/i, method: :register)
  def register(m, nickname, email)
    # Create the API so we can use the website's method of adding users
  end
end

