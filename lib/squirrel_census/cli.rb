class SquirrelCensus::CLI

	def start
		scrape
		call
	end


	def scrape
		SquirrelCensus::SquirrelAPI.new.create_squirrels_from_aoh
	end


	def call
		greeting
		command_list
		input = gets.strip.downcase
		input_validator(input)
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
				when 'shift'
					shift_report
				when 'help'
					command_list
			end
			spacer
			puts "Please enter main/total/colors/max/dates/exit : "
			input = gets.strip.downcase
			input_validator(input)
			spacer
		end
	end


	def input_validator(input)
		puts "INVALID COMMAND!" if !['exit', 'main', 'total', 'colors', 'max', 'dates', 'shift', 'help'].include?(input)
	end


	def spacer
		puts ""
	end


	def greeting
		RubyFiglet::Figlet.new("Squirrel CLI","Modular").show
	end


	def command_list
		puts ""
		puts "List of Commands"
		puts "================"
		puts "main - Main Menu"
		puts "dates - lists of dates >> menu dive for detailed info"
		puts "total - get the total number of squirrels"
		puts "colors - get a list of all the squirrel colors"
		puts "max - to reveal the max number of squirrels per hectare"
		puts "shift - reports squirrel count for each shift"
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
		SquirrelCensus::Date.sorted_dates.each.with_index(1) do |date, index|
			month = date.date[0..1]
			day = date.date[2..3]
			year = date.date[4..7]
			puts "#{index}. #{month}/#{day}/#{year} => #{date.squirrels.count} sightings"
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
			user_date_select
		else
			get_selected_date(index)
		end
	end


	def get_selected_date(index)
		list_squirrels_by_date(SquirrelCensus::Date.sorted_dates[index])
	end


	def list_squirrels_by_date(date_obj)
		puts "Squirrels counted on #{date_obj.date[0..1]}/#{date_obj.date[2..3]}/#{date_obj.date[4..7]}"
		puts "=================================="
		date_obj.squirrels.each.with_index(1) do |squirrel, index|
			puts "#{index}. ##{squirrel.unique_squirrel_id}"
		end
		select_squirrel_from_date(date_obj)
	end


	def select_squirrel_from_date(date_obj)
		puts ""
		puts "Select a Squirrel from the List"
		input = gets.strip.downcase.to_i
		index = input - 1
		if index >= 0
			sq = date_obj.squirrels[index]
			print_squirrel_profile(sq)
		else
			puts ""
			puts "**INVALID SELECTION!**"
			select_squirrel_from_date(date_obj)
		end
	end

	def print_squirrel_profile(sq)
		puts ""
		puts "Data for Selected Squirrel"
		puts "ID : #{sq.unique_squirrel_id}"
		puts "Hectare : #{sq.hectare}"
		puts "AM/PM : #{sq.shift}"
		puts "Date : #{sq.date.date}"
		puts "Primary Fur Color : #{sq.primary_fur_color}"
		puts "Highlight Fur Color : #{sq.highlight_fur_color}" if sq.highlight_fur_color
		puts "Age : #{sq.age}"
		puts "Running : #{sq.running}"
		puts "Chasing : #{sq.chasing}"
		puts "Climbing : #{sq.climbing}"
		puts "Eating : #{sq.eating}"
		puts "Foraging : #{sq.foraging}"
		puts "Kuks : #{sq.kuks}"
		puts "Quaas : #{sq.quaas}"
		puts "Moans : #{sq.moans}"
		puts "Tail Flags : #{sq.tail_flags}"
		puts "Tail Twitches : #{sq.tail_twitches}"
		puts "Approaches : #{sq.approaches}"
		puts "Indifferent : #{sq.indifferent}"
		puts "Runs From : #{sq.runs_from}"
		puts ""
		open_location_in_google_maps(sq) 
	end


	def open_location_in_google_maps(squirrel)
		# https://www.google.com/maps/search/?api=1&query=
		# negative number is second which is sq.x
		# https://www.google.com/maps/@?api=1&map_action=map&center=40.7693045133578,-73.9719735582476&zoom=12&basemap=satellite
		puts "Would you like to view the squirrel location in Google Maps? (y/n)"
		input = gets.strip.downcase
		if ['y', 'yes'].include?(input)
			prefix = "https://www.google.com/maps/search/?api=1&query="
			url = "#{prefix}#{squirrel.y},#{squirrel.x}"
			system("open '#{url}'")
		end
	end


	def shift_report
		puts "#{SquirrelCensus::Squirrel.get_shift_hash["AM"]} squirrels were spotted during the AM shift, while #{SquirrelCensus::Squirrel.get_shift_hash["PM"]} were spotted during the PM shift."
	end

end