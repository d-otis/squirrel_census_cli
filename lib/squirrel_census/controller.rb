class SquirrelCensus::Controller
	def call
		greeting
		command_list
		input = gets.chomp
		while input != 'exit'
			case input
				when 'main'
					call 
				when 'total'
					puts "#{Squirrel.all.count} squirrels counted over #{Date.all.size} days in Central Park."
				when "colors"
					Squirrel.print_fur
				when 'max'
					Squirrel.max_per_hectare
				when 'dates'
					Date.list_all_dates
					spacer
					Date.user_date_select
				when 'help'
					command_list
			end
			spacer
			puts "Please enter dates/colors/total/help/exit : "
			input = gets.chomp
			# call
			spacer
		end
		# are_you_sure?
	end

	def spacer
		puts ""
	end

	def are_you_sure?
		puts ""
		puts "Are you sure you want to exit? (y/n)"
		puts ""
		input = gets.chomp.downcase
		call if input == "n"
	end

	def greeting
		# puts "Squirrel // CLI".art!
		puts "Squirrel // CLI"
	end

	def command_list
		puts ""
		puts "List of Commands"
		puts "================"
		puts "main - Main Menu"
		puts "dates - lists the dates of the census and the number of squirrels found each day"
		puts "total - get the total number of squirrels"
		puts "colors - get a list of all the squirrel colors"
		puts "max - to reveal the max number of squirrels per hectare"
		puts "help - command list"
		puts "exit - quits program"
		puts ""
	end

end
