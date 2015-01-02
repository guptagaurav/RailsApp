class ArticlesController < ApplicationController
  load_and_authorize_resource

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # before_filter :set_current_account


  # def set_current_account
  #   #  set @current_account from session data here
  #   @curr_user = current_user.email
  #   Article.current = @curr_user
  # end

  # GET /articles
  # GET /articles.json
  def index


    # @articles = Article.all
    #   @curr_user = current_user.email
    #   puts "-----------------#{@curr_user}"
      if params[:search]
        @query = Article.search do
          fulltext params[:search]
          # facet(:email)
          # with(:email, @curr_user)
          # paginate  :page => 2 , :per_page => 1
        end
        @articles  = @query.results

        # puts "--------------------------#{@articles[0].email}"
      if user_signed_in?
        @article = Article.new
        @articles_var = Article.where(:email => @curr_user)
        @articles = @articles_var.page(params[:page]).per(2)
      end

    else
      @articles = Article.all.page(params[:page]).per(3)
    end
    # puts @articles
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    if user_signed_in?
      @article = Article.new
    else
      redirect_to new_user_session_path
    end
  end

  # GET /articles/1/edit
  def edit
    if user_signed_in?
    else
      redirect_to new_user_session_path
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save && @article.update_attributes(:email => current_user.email )
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    if user_signed_in?
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if user_signed_in?
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to new_user_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :caption, :matter, :photo, :search)
    end
end
