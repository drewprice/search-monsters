class User < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessor :suggestions

  has_many :posts
  has_many :active_relationships,
           class_name:  'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :passive_relationships,
           class_name:  'Relationship',
           foreign_key: 'followed_id',
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
                      medium: '300x300>',
                      thumb: '100x100>',
                      post: '50x50>'
                    },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}

  searchkick autocomplete: ['username']

  def self.random_avatar
    image_path = Dir['public/images/trainers/*'].sample
    File.open(image_path)
  end

  def self.random_username
    Bazaar.object.split.map(&:capitalize).join(' ')
  end

  def self.random_bio
    Faker::Hacker.say_something_smart
  end

  def follow(user)
    active_relationships.create(followed_id: user.id) unless following.include?(user)
    update_relationships
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy if following.include?(user)
    update_relationships
  end

  def suggest
    @suggestions ||= Suggestion.new(self)
  end

  def timeline_posts(page)
    @users_followers = following.map(&:id) << self.id
    # @users_followers << self.id
    @timeline_posts = Post.reorder('created_at DESC').where(user_id: @users_followers).page(page).per_page(Post::POSTS_PER_PAGE)
  end

  private

  def update_suggestions
    @suggestions = Suggestion.new(self)
  end

  def update_relationships
    reload
    update_suggestions
  end

  # TODO: Refactor such that conditional assignment is not necessary
  def random_setup
    self.username ||= User.random_username
    self.bio ||= User.random_bio
    self.avatar = User.random_avatar unless avatar_file_name
  end
end
