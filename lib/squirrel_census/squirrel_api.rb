class SquirrelCensus::SquirrelAPI

	def get_json
		url = 'https://data.cityofnewyork.us/resource/vfnx-vebw.json?$$app_token=pZZ5ZSjEylb8x5UpVjVKoeByW'
		uri = URI(url)
		res = Net::HTTP.get(uri)
		json = JSON.parse(res)
	end

	def get_squirrel_aoh
		get_json.collect do |squirrel|
			squirrel_hash = {
				"x" => squirrel["x"],
				"y" => squirrel["y"],
				"unique_squirrel_id" => squirrel["unique_squirrel_id"],
				"hectare" => squirrel["hectare"],
				"shift" => squirrel["shift"],
				"date" => squirrel["date"],
				"primary_fur_color" => squirrel["primary_fur_color"],
				"highlight_fur_color" => squirrel["highlight_fur_color"],
				"combination_of_primary_and" => squirrel["combination_of_primary_and"],
				"age" => squirrel["age"],
				"running" => squirrel["running"],
				"chasing" => squirrel["chasing"],
				"climbing" => squirrel["climbing"],
				"eating" => squirrel["eating"],
				"foraging" => squirrel["foraging"],
				"kuks" => squirrel["kuks"],
				"quaas" => squirrel["quaas"],
				"moans" => squirrel["moans"],
				"tail_flags" => squirrel["tail_flags"],
				"tail_twitches" => squirrel["tail_twitches"],
				"approaches" => squirrel["approaches"],
				"indifferent" => squirrel["indifferent"],
				"runs_from" => squirrel["runs_from"]
			}
		end
	end

	def create_squirrels_from_aoh
		get_squirrel_aoh.each do |squirrel_hash|
			SquirrelCensus::Squirrel.new(squirrel_hash)
		end
	end

end