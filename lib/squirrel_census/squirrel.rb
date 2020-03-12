class SquirrelCensus::Squirrel

	attr_accessor :x, :y, :unique_squirrel_id, :hectare, :shift, :date, :hectare_squirrel_number, :age, :primary_fur_color, :highlight_fur_color, :combination_of_primary_and, :location, :above_ground_sighter, :running, :chasing, :climbing, :eating, :foraging, :kuks, :quaas, :moans, :tail_flags, :tail_twitches, :approaches, :indifferent, :runs_from

	@@all = []

	def initialize(attrs)
		attrs.each do |k,v|
			k != 'date' ? self.send("#{k}=", v) : self.date = SquirrelCensus::Date.find_or_create_by_date(v, self)
		end
		save
	end

	def save
		@@all << self
	end

	def self.all
		@@all
	end

	# https://www.google.com/maps/search/?api=1&query=
	# negative number is second which is sq.x
	# https://www.google.com/maps/@?api=1&map_action=map&center=40.7693045133578,-73.9719735582476&zoom=12&basemap=satellite


	def self.get_fur_hash
		fur_hash = {"No Color Reported" => 0}
		self.all.each do |squirrel|
			!fur_hash[squirrel.primary_fur_color] ? fur_hash[squirrel.primary_fur_color] = 1 : fur_hash[squirrel.primary_fur_color] += 1
		end
		fur_hash["No Color Reported"] = fur_hash.delete(nil)
		fur_hash
	end

	def self.get_shift_hash
		shift_hash = {}
		self.all.each do |squirrel|
			!shift_hash[squirrel.shift] ? shift_hash[squirrel.shift] = 1 : shift_hash[squirrel.shift] += 1
		end
		shift_hash
	end


	# def self.get_age_hash
	# 	age_hash = {}
	# 	self.all.each do |squirrel|
	# 		if !age_hash[squirrel.age]
	# 			age_hash[squirrel.age] = 1
	# 		else
	# 			age_hash[squirrel.age] += 1
	# 		end
	# 	end
	# 	age_hash["Age Not Reported"] = age_hash.delete(nil)
	# 	age_hash
	# end


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