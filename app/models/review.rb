class Review < ActiveRecord::Base
	attr_accessible :content

	validates :content, presence: true
	
	default_scope -> { order('created_at DESC') }
	belongs_to :user
	belongs_to :book

	def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
