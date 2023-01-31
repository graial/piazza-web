class ApplicationRecord < ActiveRecord::Base
  include MessageVerifier, HumanEnum

  primary_abstract_class
end
