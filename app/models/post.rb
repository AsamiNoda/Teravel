class Post < ApplicationRecord
	belongs_to :user, optional: true
	has_many :post_comments
	has_many :favorites
	has_many :tag_maps, dependent: :destroy
	has_many :tags, through: :tag_maps
	attachment :post_image, destroy: false
	validates :body ,presence: true, length: {maximum: 200}
	validates :post_image ,presence: true
	def favorited_by?(user)
    	favorites.where(user_id: user.id).exists?
  	end

  	def save_tag(sent_tags)
	    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
	    old_tags = current_tags - sent_tags
	    new_tags = sent_tags - current_tags

	    old_tags.each do |old|
	      self.tags.delete Tag.find_by(tag_name: old)
	    end

	    new_tags.each do |new|
	      new_tag_map = Tag.find_or_create_by(tag_name: new)
	      self.tags << new_tag_map
	    end
	end
end
