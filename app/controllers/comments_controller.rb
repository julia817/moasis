class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    comment = Comment.new(comment_params)
    # @comment.user_id = current_user.id
    # puts @comment.user_id
    # @comment.movie_id = params[:id]
    if comment.save
      flash[:success] = "コメント発表成功！"
    else
      flash[:danger] = "コメント発表失敗"
    end
    redirect_to :back
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :movie_id, :user_id)
    end

end
