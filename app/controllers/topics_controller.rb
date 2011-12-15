class TopicsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :admin_required, :only => :destroy
  
  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
    @post = Post.new
  end

  def create
    @topic = Topic.new(:name => params[:topic][:name], :last_poster_id => current_user.id, :last_post_at => Time.now, :forum_id => params[:topic][:forum_id], :user_id => current_user.id)
    if @topic.save
      @post = Post.new(:content => params[:post][:content], :topic_id => Topic.first.id, :user_id => current_user.id)

      if @post.save
        flash[:notice] = "Successfully created topic."
        redirect_to "/forums/#{@topic.forum_id}"
      else
        redirect :action => 'new'
      end
    else
    render :action => 'new'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to "/forums/#{@topic.forum_id}", :notice => "Successfully destroyed topic."
  end
end
