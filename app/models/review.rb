class Review < ActiveRecord::Base
	attr_accessible :content

	belongs_to :user
	belongs_to :book
end
