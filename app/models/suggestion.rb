class Suggestion
  def initialize(user)
    @user = user
    @pool = sorted_pool

    self
  end

  def first
    @pool[0][0]
  end

  def second
    @pool[1][0]
  end

  def third
    @pool[2][0]
  end

  def last
    @pool.last[0]
  end

  def top(n = 1)
    @pool[0...n].map(&:first)
  end

  def top_three
    top(3)
  end

  def sample(n = 1)
    @pool.sample(n).map(&:first)
  end

  private

  def generate_pool
    @user.following.map(&:following).flatten - ([@user] + @user.following)
  end

  def rank_pool
    generate_pool.each_with_object(Hash.new(0)) do |suggested_user, rankings|
      rankings[suggested_user] += 1
    end.to_a
  end

  def sorted_pool
    if @user.following.empty? || generate_pool.count < 3
      User.all.sample(5).map { |user| [user, 'unranked'] }
    else
      rank_pool.sort_by(&:last).reverse
    end
  end
end
