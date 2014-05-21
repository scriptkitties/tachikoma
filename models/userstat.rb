#!/usr/bin/env ruby

require "sequel"

class UserStatModel < Sequel::Model($DB["s"][:user_stats])
end
