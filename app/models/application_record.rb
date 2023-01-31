class ApplicationRecord < ActiveRecord::Base
  include MessageVerifier

  primary_abstract_class
end
