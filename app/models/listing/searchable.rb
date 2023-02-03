module Listing::Searchable
	extend ActiveSupport::Concern

	included do 
		scope :search, ->(query) {
			websearch_to_tsquery = Arel::Nodes::NamedFunction.new(
				"websearch_to_tsquery",
				[
					Arel::Nodes::SqlLiteral.new("'english'"),
					Arel::Nodes::SqlLiteral.new(
						sanitize_sql_array(["?", query])
					)
				]
			)
			ts_rank = Arel::Nodes::NamedFunction.new(
				"ts_rank",
				[arel_table[:searchable], websearch_to_tsquery]
			)

			where = Arel::Nodes::InfixOperation.new(
				"@@",
				arel_table[:searchable],
				websearch_to_tsquery
			)

			select(Arel.star, ts_rank.as("rank"))
				.where(where)
				.order("rank DESC")
		}

		scope :near, ->(location) {
			select(Arel.star)
				.joins(:address)
				.merge(Address.near(location))
		}

		scope :filter_by_tags, ->(tags) {
			where("tags @> ARRAY[?]::varchar[]", tags)
		}
	end
end