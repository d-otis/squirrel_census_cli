class SquirrelCensus::Date

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

end