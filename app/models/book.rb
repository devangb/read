class Book < ActiveRecord::Base
	attr_accessible :title, :isbn, :author, :content

	has_many :reviews
	validates :title, presence: true
	validates :isbn, presence: true, length: {maximum: 13, minimum: 13}
	validates :author, presence: true


	has_many :reader_relationships, foreign_key: "reader_id", dependent: :destroy
	has_many :read_books, through: :reader_relationships, source: :read
	has_many :reverse_reader_relationships, foreign_key: "read_id",
                                   class_name:  "ReaderRelationship",
                                   dependent:   :destroy
  	has_many :readers, through: :reverse_reader_relationships, source: :reader

	def read?(book)
    	reader_relationships.find_by(read_id: book.id)
  	end

  	def read!(book)
    	reader_relationships.create!(read_id: book.id)
  	end

  	def unread!(book)
    	reader_relationships.find_by(read_id: book.id).destroy!
  	end
	
	# has_many :reviewers, :class_name => "User", :through => :reviews

end
