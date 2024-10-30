class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    Rails.logger.info("found article #{@article.id}")
    @comment = @article.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to article_path(@article), notice: "Comment was successfully created."
    else
      render "articles/show", status: :unprocessable_entity, alert: "Something went very wrong. Comment was not created."
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    unless is_author?(@comment)
      return redirect_to article_path(@article), alert: "You are not allowed to do that."
    end

    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :status)
  end

  private
  def is_author? (comment)
    comment.author.id == current_user.id
  end
end
