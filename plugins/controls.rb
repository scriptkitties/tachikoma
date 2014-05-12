#!/usr/bin/env ruby

require "cinch"

class Controls
	include Cinch::Plugin

	match "quit"
	def execute(m)
		bot.quit
	end
end

