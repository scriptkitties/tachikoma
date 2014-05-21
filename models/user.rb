#!/usr/bin/env ruby

require "sequel"

class UserModel < Sequel::Model($DB["s"][:users])
end
