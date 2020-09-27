class Spot < ApplicationRecord
  belongs_to :post
  geocoded_by :address
  before_validation :geocode
  validates :address ,presence: true

  validate :check_latitude
  validate :check_longitude

 def check_latitude
	if self.latitude.nil?
		errors.add(:latitude,  "の値が不正です")
	end
  end
  def check_longitude
  	if self.longitude.nil?
  		errors.add(:longitude,  "の値が不正です")
  	end
  end

end