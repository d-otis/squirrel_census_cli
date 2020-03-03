class SquirrelCensus::CLI
	# include Spacer

	def start
		scrape
		call
	end

	def scrape
		SquirrelCensus::Scraper.new.create_squirrels_from_aoh
	end


	def call
		greeting
		command_list
		input = gets.strip.downcase
		while input != 'exit'
			case input
				when 'main'
					call 
				when 'total'
					total
				when "colors"
					print_fur
				when 'max'
					max_per_hectare
				when 'dates'
					list_all_dates
					spacer
					user_date_select
				when 'help'
					command_list
			end
			spacer
			puts "Please enter main/total/colors/max/dates/exit : "
			input = gets.strip.downcase
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
		input = gets.strip.downcase
		call if input == "n"
	end

	def greeting
		RubyFiglet::Figlet.new("Squirrel CLI","Modular").show
	end

	def command_list
		puts ""
		# RubyFiglet::Figlet.new("List of Commands","catwalk").show
		puts "List of Commands"
		puts "================"
		puts "main - Main Menu"
		puts "dates - lists of dates >> menu dive for detailed info"
		puts "total - get the total number of squirrels"
		puts "colors - get a list of all the squirrel colors"
		puts "max - to reveal the max number of squirrels per hectare"
		puts "help - command list"
		puts "exit - quits program"
		puts ""
	end

	def print_fur
		SquirrelCensus::Squirrel.get_fur_hash.each do |color, num|
			puts "There were #{num} #{color.downcase} squirrels."
		end
	end

	def total
		puts "#{SquirrelCensus::Squirrel.all.count} squirrels counted over #{SquirrelCensus::Date.all.size} days in Central Park."
	end

	def max_per_hectare
		max = SquirrelCensus::Squirrel.get_hectare_hash.max_by {|k,v| v}
		puts "The most squirrels per hectare were #{max[1]} in hectare: #{max[0]}"
	end

	def list_all_dates
		SquirrelCensus::Date.sorted_dates.each_with_index do |date, index|
			month = date.date[0..1]
			day = date.date[2..3]
			year = date.date[4..7]
			puts "#{index + 1}. #{month}/#{day}/#{year} => #{date.squirrels.count} sightings"
		end
	end

	def user_date_select
		puts "Select a date by number in list"
		input = gets.strip.downcase
		spacer
		index = input.to_i - 1
		if !index.between?(0, SquirrelCensus::Date.all.count)
			puts ""
			puts "Invalid Input : Please enter a number from the list"
			puts ""
		else
			SquirrelCensus::Squirrel.get_selected_date(index)
		end
	end




end
