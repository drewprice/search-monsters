class SearchesController < ApplicationController
  def show
    if params[:query].present?
        @search = User.search(params[:query].split.join(' AND '))
    else
        @search = []
    end
  end
end
