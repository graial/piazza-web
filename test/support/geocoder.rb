Geocoder.configure(lookup: :test, ip_lookup: :test)

Geocoder::Lookup::Test.add_stub(
	"London", [
		{
			"coordinates" => [51.44581075, -0.21145055411144628],
			"address" => "London",
			"country" => "United Kingdom",
			"country_code" => "GB"
		}
	]
)
Geocoder::Lookup::Test.add_stub(
	"Birmingham", [
		{
			"coordinates" => [52.4559648, -1.9038627],
			"address" => "Birmingham",
			"country" => "United Kingdom",
			"country_code" => "GB"
		}
	]
)

Geocoder::Lookup::Test.set_default_stub(
	[
		{
			"coordinates" => [53.4062724, -2.9879004],
			"address" => "Liverpool",
			"country" => "United Kingdom",
			"country_code" => "GB"
		}
	]
)