class User < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :posts
  has_many :active_relationships,
              class_name:  "Relationship",
              foreign_key: "follower_id",
              dependent: :destroy
  has_many :passive_relationships,
              class_name:  "Relationship",
              foreign_key: "followed_id",
              dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # TODO: Correct this validation
  # validates :password, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true

  before_save :random_setup

  has_secure_password
  has_attached_file :avatar,
                      styles: {
                        medium: "300x300>",
                        thumb: "100x100>",
                        post: "50x50>"
                      },
                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  searchkick autocomplete: ['username']

  def self.random_avatar
    image_path = Dir['public/images/trainers/*'].sample
    File.open(image_path)
  end

  def self.random_username
    Bazaar.object.split.map{|word| word.capitalize }.join(" ")
  end

  def self.random_bio
    Faker::Hacker.say_something_smart
  end

  # TODO: Refactor?
  def timeline_posts
    timeline_posts = following.map { |user| user.posts.map { |post| post } }
    (timeline_posts += posts).flatten
  end

  # TODO: Refactor?
  def options_for_suggest
    self.following.map { |user| user.following }.flatten
  end

  # TODO: Refactor?
  def filtered_suggestions
    options_for_suggest.select { |user| !user.followers.include?(self) }
  end

  # TODO: Refactor?
  def sample_suggestions
    already_sampled_suggestions = filtered_suggestions.sample(3)

    if already_sampled_suggestions.uniq.length < 3
      sample_suggestions
    else
      already_sampled_suggestions
    end
  end

  # TODO: Refactor?
  def get_suggestions
    if following.length < 1 || sample_suggestions.size < 3
      User.all.sample(3)
    else
      sample_suggestions
    end
  end

  def follow(user)
    active_relationships.create(followed_id: user.id) unless following.include?(user)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy if following.include?(user)
  end

  private

  # TODO: Refactor such that conditional assignment is not necessary
  def random_setup
    self.username ||= User.random_username
    self.bio ||= User.random_bio
    self.avatar = User.random_avatar unless avatar_file_name
  end
end
