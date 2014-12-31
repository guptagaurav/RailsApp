class SearchController < ApplicationController

  def index
  end

  def show
  end

  def create
    def index
      @query = Article.search do
        fulltext params[:search]
        with :email, current_user.email
      end
      @search  = @query.results
      redirect_to :root
    end
  end

end
