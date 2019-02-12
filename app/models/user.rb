class User < ApplicationRecord

  has_many :movielists, dependent: :destroy

  has_many :comments
  has_many :movies, through: :comments


  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token, :reset_token

  mount_uploader :picture, PictureUploader

  validates :username,
            presence: true, unless: :uid?, 
            length: { maximum: 50 },
            uniqueness: true,
            format: { with: /\A[a-z0-9]+\z/i }

  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true, unless: :uid?, 
            length: {maximum: 254}, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password validations: false
  validates :password,
            presence: true, unless: :uid?,
            length: { minimum: 6 }

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
  # def authenticated?(remember_token)
  #   return false if remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # if the user exists in the database, get the data; otherwise, create new user
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    if provider == 'twitter'
      name = auth[:info][:nickname]
    else
      name = auth[:info][:name]
    end
    # email = auth[:info][:email]
    image = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      # user.email = email
      user.username = name
      user.pic_url = image
    end
  end

  # set the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    # update_attribute(:reset_digest,  User.digest(reset_token))
    # update_attribute(:reset_sent_at, Time.zone.now)
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # send password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # return true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
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

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    movielists_ids = "SELECT movielist_id FROM movielists
                     WHERE user_id IN (#{following_ids}) OR user_id = :user_id"
    feed_items = []
    Comment.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id).each do |comment|
      feed_items << comment
    end
    ListMovie.where("movielist_id IN (#{movielists_ids})", user_id: id).each do |movie|
      feed_items << movie
    end
    # puts feed_items
    feed_items.sort_by!{ |a| a["created_at"] }.reverse!
  end

  # user search
  # TO BE MODIFIED
  def self.search(term)
    User.where(['username LIKE ?', "%#{term}%"])
  end

  # compare given user's given list with current user's watched list to get current user's watched list
  def self.my_watched(other_user_list_id, current_user_id)
    current_user_movielist = User.find(current_user_id).movielists.find_by(listname: "watched")
    other_user_list = ListMovie.where(movielist_id: other_user_list_id)
    my_watched = Array.new
    other_user_list.each do |movie|
      if ListMovie.exists?(movielist_id: current_user_movielist.id, movie_id: movie.movie_id)
        my_watched << movie
      end
    end
    my_watched
  end

  # compare given user's given list with current user's watched list to get current user's unwatched list
  def self.my_unwatched(other_user_list_id, current_user_id)
    current_user_movielist = User.find(current_user_id).movielists.find_by(listname: "watched")
    other_user_list = ListMovie.where(movielist_id: other_user_list_id)
    my_unwatched = Array.new
    other_user_list.each do |movie|
      unless ListMovie.exists?(movielist_id: current_user_movielist.id, movie_id: movie.movie_id)
        my_unwatched << movie
      end
    end
    my_unwatched
  end

  private
    # converts email to all lower-case.
    def downcase_email
      self.email = email.downcase unless self.email.nil?
    end

    # validate the size of an uploaded picture
    def picture_size
        if picture.size > 3.megabytes
          errors.add(:picture, "should be less than 3MB")
        end
      end

    # return the current logged-in user (if any)
    # def current_user
      # if session[:user_id]
      #   @current_user ||= User.find_by(id: session[:user_id])
      # end
    #   if (user_id = session[:user_id])
    #     @current_user ||= User.find_by(id: user_id)
    #   elsif (user_id = cookies.signed[:user_id])
    #     # raise # tests still pass, so this branch is currently untested
    #     user = User.find_by(id: user_id)
    #     if user && user.authenticated?(cookies[:remember_token])
    #       log_in user
    #       @current_user = user
    #     end
    #   end
    # end
end
