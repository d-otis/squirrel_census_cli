class SquirrelCensus::Squirrel

	attr_accessor :x, :y, :unique_squirrel_id, :hectare, :shift, :date, :hectare_squirrel_number, :age, :primary_fur_color, :highlight_fur_color, :combination_of_primary_and, :location, :above_ground_sighter, :running, :chasing, :climbing, :eating, :foraging, :kuks, :quaas, :moans, :tail_flags, :tail_twitches, :approaches, :indifferent, :runs_from

	@@all = []

	def initialize(attrs)
		attrs.each do |k,v|
			if k != "date"
				self.send("#{k}=", v)
			else
				self.date = SquirrelCensus::Date.find_or_create_by_date(v, self)
			end
		end
		save
	end

	def save
		@@all << self
	end

	def self.all
		@@all
	end

	def self.reset_all
		@@all.clear
	end

	def self.get_selected_date(index)
		self.list_squirrels_by_date(SquirrelCensus::Date.sorted_dates[index])
	end

	def self.list_squirrels_by_date(date_obj)
		puts "Squirrels counted on #{date_obj.date[0..1]}/#{date_obj.date[2..3]}/#{date_obj.date[4..7]}"
		date_obj.squirrels.each_with_index do |squirrel, index|
			afraid = squirrel.runs_from == true ? true : false
			puts "#{index + 1}. ##{squirrel.unique_squirrel_id}"
		end
		select_squirrel_from_date(date_obj)
	end

	def self.select_squirrel_from_date(date_obj)
		puts ""
		puts "Select a Squirrel from the List"
		index = gets.chomp.to_i - 1
		sq = date_obj.squirrels[index]
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
	end

	def self.get_fur_hash
		fur_hash = {"No Color Reported" => 0}
		self.all.each do |squirrel|
			# binding.pry
			if !fur_hash[squirrel.primary_fur_color]
				fur_hash[squirrel.primary_fur_color] = 1
			else
				fur_hash[squirrel.primary_fur_color] += 1
			end
		end
		fur_hash["No Color Reported"] = fur_hash.delete(nil)
		fur_hash
	end

	def self.get_shift_hash
		shift_hash = {}
		self.all.each do |squirrel|
			if !shift_hash[squirrel.shift]
				shift_hash[squirrel.shift] = 1
			else
				shift_hash[squirrel.shift] += 1
			end
		end
		shift_hash
	end

	def self.shift_report
		puts "#{get_shift_hash["AM"]} squirrels were spotted during the AM shift, while #{get_shift_hash["PM"]} were spotted during the PM shift."
	end

	def self.get_age_hash
		age_hash = {}
		self.all.each do |squirrel|
			if !age_hash[squirrel.age]
				age_hash[squirrel.age] = 1
			else
				age_hash[squirrel.age] += 1
			end
		end
		age_hash["Age Not Reported"] = age_hash.delete(nil)
		age_hash
	end

	def self.age_report
		get_age_hash.each do |age, num|
			puts "There are #{num} '#{age}' squirrels"
		end
	end

	def self.find_by_hectare(hect)
		self.all.select {|squirrel| squirrel.hectare == hect}
	end

	def self.get_hectare_hash
		hect_hash = {}
		self.all.each do |squirrel|
			if !hect_hash[squirrel.hectare]
				hect_hash[squirrel.hectare] = 1
			else
				hect_hash[squirrel.hectare] += 1
			end
		end
		hect_hash
	end


end