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

      @search = Article.search(params[:q])

    # @articles = Article.all
    #   @curr_user = current_user.email
    #   puts "-----------------#{@curr_user}"
          if user_signed_in?
            @article = Article.new
            @articles = Article.all.page(params[:page]).per(2)
          else
            @articles = Article.all.page(params[:page]).per(3)
          end

        @articles  = @search.result.page(params[:page]).per(3)

  end
    # puts @articles
  # GET /articles/1
  # GET /articles/1.json
  def show
    @search = Article.search(params[:q])
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ShowPdf.new(@article)
        send_data pdf.render, type: "application/pdf"
      end
    end

  end
  # GET /articles/new
  def new
    @search = Article.search(params[:q])

    if user_signed_in?
      @article = Article.new
    else
      redirect_to new_user_session_path
    end
  end

  # GET /articles/1/edit
  def edit

    @search = Article.search(params[:q])

    if user_signed_in?
    else
      redirect_to new_user_session_path
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @search = Article.search(params[:q])
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
    @search = Article.search(params[:q])

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
    @search = Article.search(params[:q])

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
