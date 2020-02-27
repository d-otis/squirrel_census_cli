class SquirrelCensus::Scraper

	def get_json
		url = 'https://data.cityofnewyork.us/resource/vfnx-vebw.json?$$app_token=pZZ5ZSjEylb8x5UpVjVKoeByW'
		uri = URI(url)
		res = Net::HTTP.get(uri)
		json = JSON.parse(res)
	end

	def make_squirrels
		get_json.each do |squirrel|
			new_squirrel = SquirrelCensus::Squirrel.new
			new_squirrel.unique_squirrel_id = squirrel["unique_squirrel_id"]
			new_squirrel.hectare = squirrel["hectare"]
			new_squirrel.shift = squirrel["shift"]
			new_squirrel.date = SquirrelCensus::Date.find_or_create_by_date(squirrel['date'], new_squirrel)
			new_squirrel.primary_fur_color = squirrel["primary_fur_color"] if squirrel["primary_fur_color"]
			new_squirrel.highlight_fur_color = squirrel["highlight_fur_color"] if squirrel["highlight_fur_color"]
			new_squirrel.combination_of_primary_and = squirrel["combination_of_primary_and"] if squirrel["highlight_fur_color"] && squirrel["primary_fur_color"]
			new_squirrel.age = squirrel["age"]
			new_squirrel.running = squirrel["running"]
			new_squirrel.chasing = squirrel["chasing"]
			new_squirrel.climbing = squirrel["climbing"]
			new_squirrel.eating = squirrel["eating"]
			new_squirrel.foraging = squirrel["foraging"]
			new_squirrel.kuks = squirrel["kuks"]
			new_squirrel.quaas = squirrel["quaas"]
			new_squirrel.moans = squirrel["moans"]
			new_squirrel.tail_flags = squirrel["tail_flags"]
			new_squirrel.tail_twitches = squirrel["tail_twitches"]
			new_squirrel.approaches = squirrel["approaches"]
			new_squirrel.indifferent = squirrel["indifferent"]
			new_squirrel.runs_from = squirrel["runs_from"]
		end
	end
end

# Scraper.new.make_squirrels
# binding.pry