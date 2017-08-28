class AdminPostsController < ApplicationController
  before_action :set_admin_post, only: [:show, :edit, :update, :destroy]
  # before_action :set_false_info, only: [:create]

  # GET /admin_posts
  # GET /admin_posts.json
  def index
    @admin_posts = AdminPost.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def video_url
    @video_url = current_user.youtube_url
    unless @video_url.present?
      @video_url = current_user.build_youtube_url
    end
  end

  def save_video_url
    @video = YoutubeUrl.find_by(id: params[:id])
    if @video.present?
      @video.update_attributes(video_params)
    else
      @save_video = current_user.create_youtube_url(video_params)
    end
    redirect_to root_path
  end

  # GET /admin_posts/1
  # GET /admin_posts/1.json
  def show
  end

  # GET /admin_posts/new
  def new
    @admin_post = current_user.admin_posts.build
  end

  # GET /admin_posts/1/edit
  def edit
  end

  # POST /admin_posts
  # POST /admin_posts.json
  def create
    @admin_post = current_user.admin_posts.new(admin_post_params)

    respond_to do |format|
      if @admin_post.save
        flash[:success] = 'Admin post was successfully created.'
        format.html { redirect_to admin_posts_path }
        format.json { render :show, status: :created, location: @admin_post }
      else
        flash[:error] = @admin_post.errors.full_messages
        format.html { render :new }
        format.json { render json: @admin_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_posts/1
  # PATCH/PUT /admin_posts/1.json
  def update
    respond_to do |format|
      if @admin_post.update(admin_post_params)
        flash[:success] = 'Admin post was successfully updated.'
        format.html { redirect_to @admin_post}
        format.json { render :show, status: :ok, location: @admin_post }
      else
        flash[:error] = @admin_post.errors.full_messages
        format.html { render :edit }
        format.json { render json: @admin_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_posts/1
  # DELETE /admin_posts/1.json
  def destroy
    @admin_post.destroy
    flash[:success] = 'Admin post was successfully destroyed.'
    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_post
      @admin_post = AdminPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_post_params
      params.require(:admin_post).permit(:url, :title, :message, :is_active, :user_id)
    end

    def video_params
      params.require(:youtube_url).permit(:url, :user_id)
    end

    def set_false_info
      @info = AdminPost.where(is_active: true).first
      @info.update_attributes(is_active: false) if @info
    end
end
