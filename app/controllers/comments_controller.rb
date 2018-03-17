class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    # activeModel::ForbiddenAttributesError
    # @comment = @post.comments.create(params[:comment])
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
  # Using a private method to encapsulate the permissible parameters
  # is just a good pattern since you'll be able to reuse the same
  # permit list between create and update. Also, you can specialize
  # this method with per-user checking of permissible attributes.
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
