class User < ActiveRecord::Base
  has_secure_password
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  searchkick autocomplete: ['username']

  has_many :active_relationships, class_name:  "Relationship",
                                 foreign_key: "follower_id",
                                 dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts


  validates :email, presence: true, uniqueness: true
  # validates :password, length: { minimum: 6}

  before_save :random_setup

  def timeline_posts
    timeline_posts = following.map{|user| user.posts.map {|post| post}}
    (timeline_posts += posts).flatten
  end

  def self.random_avatar
    image_path = Dir['public/images/trainers/*'].sample
    File.open(image_path)
  end

  def self.random_username
    Bazaar.object.split.map{|word| word.capitalize }.join(" ")
  end

  def follow(user)
    unless following.include?(user)
      active_relationships.create(followed_id: user.id)
    end
  end

  def unfollow(user)
    if following.include?(user)
      active_relationships.find_by(followed_id: user.id).destroy
    end
  end

  def self.random_bio
    Faker::Hacker.say_something_smart
  end

  private

  def random_setup
    self.username ||= User.random_username
    self.bio ||= User.random_bio
    self.avatar = User.random_avatar unless avatar_file_name
  end

end
