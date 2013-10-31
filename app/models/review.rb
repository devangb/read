class Review < ActiveRecord::Base
	attr_accessible :content

	validates :content, presence: true
	
	default_scope -> { order('created_at DESC') }
	belongs_to :user
	belongs_to :book
end
