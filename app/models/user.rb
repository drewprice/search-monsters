class User < ActiveRecord::Base
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

  def timeline_posts
    timeline_posts = following.map{|user| user.posts.map {|post| post}}
    (timeline_posts += posts).flatten
  end

  def self.random_src
    Dir['public/images/trainers/*'].sample.gsub('public', '')
  end

  def self.random_name
    Bazaar.object
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

  def self.search(query)
    if (User.find_by(username: "#{query}"))
      [(User.find_by(username: "#{query}"))]
    else
     (User.where("username LIKE ?", "%#{query}%"))
   end

 end

end
