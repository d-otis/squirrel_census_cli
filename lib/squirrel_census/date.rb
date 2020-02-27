class SquirrelCensus::Date
	# include Formatting

	attr_accessor :date, :squirrels

	@@all = []

	def initialize
		save
		@squirrels = []
	end

	def self.find_or_create_by_date(date, squirrel)
		if self.all.find {|date_instance| date_instance.date == date}
			self.all.find {|date_instance| date_instance.date == date}.squirrels << squirrel
			self.all.find {|date_instance| date_instance.date == date}
		else
			new_date = SquirrelCensus::Date.new
			new_date.date = date
			new_date.squirrels << squirrel
			new_date
		end
	end

	def squirrels
		@squirrels
	end

	def save
		@@all << self
	end

	def self.all
		@@all
	end

	def self.sorted_dates
		SquirrelCensus::Date.all.sort_by(&:date)
	end

	# def self.list_all_dates
	# 	self.sorted_dates.each_with_index do |date, index|
	# 		month = date.date[0..1]
	# 		day = date.date[2..3]
	# 		year = date.date[4..7]
	# 		puts "#{index + 1}. #{month}/#{day}/#{year} => #{date.squirrels.count} sightings"
	# 	end
	# end

	# def self.user_date_select
	# 	puts "Select a date by number in list"
	# 	input = gets.chomp.downcase
	# 	puts ""
	# 	index = input.to_i - 1
	# 	if !index.between?(0, SquirrelCensus::Date.all.count)
	# 		puts ""
	# 		puts "Invalid Input : Please enter a number from the list"
	# 		puts ""
	# 	else
	# 		SquirrelCensus::Squirrel.get_selected_date(index)
	# 	end
	# end

end

# binding.pry