class RetweetsController < ApplicationController
  def create
    @retweet = Retweet.new(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    @retweet.save
    #redirect_to("/posts/#{params[:post_id]}")
    redirect_to("/posts/index")
  end

  def destroy
    @retweet = Retweet.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    @retweet.destroy
    #redirect_to("/posts/#{params[:post_id]}")
    redirect_to("/posts/index")
  end
end
