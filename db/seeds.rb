100.times do 
	user = User.create(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: "password"
	)
	Organization.create(members: [user])
end

1000.times do 
	random_user = User.offset(rand(User.count)).first
	cover_photo_blob = ActiveStorage::Blob.create_and_upload!(
		io: StringIO.new(File.read(Rails.root.join(
			"test", "fixtures", "files", "test-image-#{rand(1..9)}.jpg"
		))),
		filename: "photo.jpg",
	)
	
	Listing.create(
		creator: random_user,
		organization: random_user.organizations.first,
		title: Faker::Commerce.product_name,
		cover_photo: cover_photo_blob,
		price: Faker::Commerce.price.floor,
		condition: Listing.conditions.values.sample,
		tags: Faker::Commerce.send(:categories, 4),
		address_attributes: {
			line_1: Faker::Address.building_number,
			line_2: Faker::Address.street_address,
			city: Faker::Address.city,
			country: "GB",
			postcode: Faker::Address.postcode
		}
	)
end