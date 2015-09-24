class Post < ActiveRecord::Base
  POSTS_PER_PAGE = 20

  belongs_to :user

  validates :body, presence: true

  def self.all_for(page)
    reorder('created_at DESC').page(page).per_page(POSTS_PER_PAGE)
  end
end
