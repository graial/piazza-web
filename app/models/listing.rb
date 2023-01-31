class Listing < ApplicationRecord
	belongs_to :creator, class_name: "User"
	belongs_to :organization

	validates :title, length: { in: 10..100 }
	validates :price, numericality: { only_integer: true }
end
