class Listing < ApplicationRecord
	belongs_to :creator, class_name: "User"
	belongs_to :organization

	validates :title, length: { in: 10..100 }
	validates :price, numericality: { only_integer: true }
	validates :condition, presence: true
	validates :tags, length: { in: 1..5 }

	enum condition: {
		mint: "mint", near_mint: "near_mint", 
		used: "used", defective: "defective" 
	} 

	before_save :downcase_tags

	private

	def downcase_tags
		self.tags = tags.map(&:downcase)
	end
end