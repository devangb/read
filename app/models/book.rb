class Book < ActiveRecord::Base
	attr_accessible :title, :isbn, :author, :content

	has_many :reviews
	
	# has_many :reviewers, :class_name => "User", :through => :reviews

end
