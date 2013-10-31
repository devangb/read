class Book < ActiveRecord::Base
	attr_accessible :title, :isbn, :author, :content

	has_many :reviews
	validates :title, presence: true
	validates :isbn, presence: true, length: {maximum: 13, minimum: 13}
	validates :author, presence: true
	
	# has_many :reviewers, :class_name => "User", :through => :reviews

end
