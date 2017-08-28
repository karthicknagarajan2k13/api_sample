module HomesHelper
  def embed(youtube_url)
    youtube_id = youtube_url.split("=").last
    "//www.youtube.com/embed/#{youtube_id}"
  end
  def get_admin_name(post)
    post ? post.user.name : ""
  end
end
