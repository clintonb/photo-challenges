class DataSource < ActiveRecord::Base
  validates :name, :presence => true
end
