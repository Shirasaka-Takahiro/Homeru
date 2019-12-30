class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  require 'obscenity/active_model'
end
