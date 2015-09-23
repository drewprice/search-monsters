class Post < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true

  def self.num_per_page
    20
  end
end
