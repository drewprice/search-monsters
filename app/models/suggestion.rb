class Suggestion

  attr_reader :list

  def initialize(user_object)
    #return suggestions array
    @user = user_object
    @list = filtered_suggestions

  end

  # TODO: Refactor?
  def options_for_suggest
    @suggestion_options = @user.following.map(&:following).flatten
  end

  # TODO: Refactor?
  def filtered_suggestions
    @filtered_suggestions = options_for_suggest.reject { |user| user.followers.include?(@user) }
  end

  # TODO: Refactor?
  def sample_suggestions
    if @list.length < 3
      User.all.sample(3)
    else
      @list.sample(3)
    end
  end
end
