class TwittersController < ApplicationController

  def show
    @timeline = Twitter.user_timeline("GRIDArendal").first(5)

    render :json => @timeline
  end

end
