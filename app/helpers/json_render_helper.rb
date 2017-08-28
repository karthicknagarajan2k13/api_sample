module JsonRenderHelper
  def render_success(data = {}, status = :ok)
    h = {
      result: true
    }
    h.merge!(data)
    render json: h, status: status
  end

  def render_failed(data = {}, status = :ok)
    h = {
      result: false
    }
    h.merge!(data)
    render json: h, status: status
  end
end