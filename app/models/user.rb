class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :person_id, :person_type, :rateable_id, :rateable_type, :weight
  validates :name, presence: true
  

  has_many :reviews
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  #book read
  has_many :reader_relationships, foreign_key: "reader_id", dependent: :destroy
  has_many :read_books, through: :reader_relationships, source: :read
  has_many :reverse_reader_relationships, foreign_key: "read_id",
                                   class_name:  "ReaderRelationship",
                                   dependent:   :destroy
  has_many :readers, through: :reverse_reader_relationships, source: :reader


  ajaxful_rater

  has_own_preferences

  searchable do 
    text :name
  end

  def feed
    Review.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  #books
  def read?(book)
    reader_relationships.find_by(read_id: book.id)
  end

  def read!(book)
    reader_relationships.create!(read_id: book.id)
  end

  def unread!(book)
    reader_relationships.find_by(read_id: book.id).destroy!
  end
end
