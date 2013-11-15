class ReaderRelationship < ActiveRecord::Base
	attr_accessible :reader_id, :read_id
	belongs_to :reader, class_name: "User"
  	belongs_to :read, class_name: "Book"

  	validates :reader_id, presence: true
  	validates :read_id, presence: true
end
