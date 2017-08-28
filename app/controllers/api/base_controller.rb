module Api
  class BaseController < ApplicationController
		include JsonRenderHelper
    skip_before_action :verify_authenticity_token
    rescue_from ActionController::ParameterMissing, with: :params_missing

    private

    def load_app_data
      @app_data = YAML.load_file(Rails.root.join('config', 'data.yml'))
    end

    def params_missing(_error)
      render_failed(msg: 'Parameter missing')
    end
  end
end