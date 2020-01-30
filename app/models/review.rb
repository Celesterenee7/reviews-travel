class Review < ApplicationRecord
  belongs_to :destination
  
  validates :author, presence: true
  validates :content_body, presence: true
  validates :rating, presence: true

  scope :search, -> (input_parameter) { where("author like ? or content_body like ? or rating = ?", "%#{input_parameter}%", "%#{input_parameter}%", input_parameter.to_i) }
end
