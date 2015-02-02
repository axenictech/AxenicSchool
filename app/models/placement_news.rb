class PlacementNews < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  validates :content, presence: true, length: { minimum: 1, maximum: 9000 }
end
