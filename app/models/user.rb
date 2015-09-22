class User < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  searchkick autocomplete: ['username']

  has_secure_password
  has_many :active_relationships, class_name:  "Relationship",
                                 foreign_key: "follower_id",
                                 dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts

  before_save :random_setup

  def timeline_posts
    timeline_posts = following.map{|user| user.posts.map {|post| post}}
    (timeline_posts += posts).flatten
  end

  def self.random_image_src
    Dir['public/images/trainers/*'].sample.gsub('public', '')
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
    self.image_src ||= User.random_image_src
    self.bio ||= User.random_bio
  end

end
