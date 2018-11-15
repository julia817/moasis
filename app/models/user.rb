class User < ApplicationRecord
	has_many :movielists, dependent: :destroy

	has_many :active_relationships, class_name: "Relationship",
																  foreign_key: "follower_id",
																	dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed

	has_many :passive_relationships, class_name: "Relationship",
																	 foreign_key: "followed_id",
																	 dependent: :destroy
	has_many :followers, through: :passive_relationships, source: :follower

	attr_accessor :remember_token

	mount_uploader :picture, PictureUploader

	validates :username, presence: true, length: { maximum: 50 }

	before_save { email.downcase! }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 254}, 
					  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	validate :picture_size


	# return the hash digest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# return a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# remember a user in the database for use in persistent sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# return true if the given token matches the digest
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# forget a user
	def forget
		update_attribute(:remember_digest, nil)
	end

	# follow a user
	def follow(other_user)
		following << other_user
	end

	# unfollow a user
	def unfollow(other_user)
		following.delete(other_user)
	end

	# return true if the current user is following the other user
	def following?(other_user)
		following.include?(other_user)
	end

	private
		# validate the size of an uploaded picture
		def picture_size
	  		if picture.size > 3.megabytes
	  			errors.add(:picture, "should be less than 3MB")
	  		end
	  	end
end
