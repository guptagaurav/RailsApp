class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @search = Article.search(params[:q])

    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    @search = Article.search(params[:q])

    respond_with(@comment)
  end

  def new
    @search = Article.search(params[:q])

    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
    @search = Article.search(params[:q])

  end

  def create
    @search = Article.search(params[:q])
    @article = Article.find(params[:article_id])
    # @comment = @article.comments.update_attributes(:user_email => current_user.email)
    @comment = @article.comments.create(comment_params)
    @comment.update_attributes(:user_email => current_user.email)
    redirect_to article_path(@article)
    # @comment.save
    # respond_with(@comment)
  end

  def update
    @search = Article.search(params[:q])

    # @article = Article.find(params[:article_id])
    @comment.update(comment_params)
    redirect_to article_url(@comment.article_id)


  end

  def destroy
    @search = Article.search(params[:q])

    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      # @email = current_user.email
      params.require(:comment).permit(:commenter, :body)
    end
end
