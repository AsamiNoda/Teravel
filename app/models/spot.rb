class Spot < ApplicationRecord
  belongs_to :post
  geocoded_by :address
  after_validation :geocode
  validates :address ,presence: true

 #  validate :check_latitude
 #  validate :check_longitude

 # def check_latitude
	# if latitude.nil?
	# 	errors.add(:latitude,  "の値が不正です")
	# end
 #  end
 #  def check_longitude
 #  	if longitude.nil?
 #  		errors.add(:longitude,  "の値が不正です")
 #  	end
 #  end

end