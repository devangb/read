class Review < ActiveRecord::Base
	attr_accessible :content
	
	default_scope -> { order('created_at DESC') }
	belongs_to :user
	belongs_to :book
end
