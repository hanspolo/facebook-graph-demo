class GraphsController < ApplicationController
  before_action :authenticate_user!

  def index
    @data = load_data
  end

  def new
  end

  def create
    if current_user.update(facebook_id: params[:uid], facebook_key: params[:token])
      flash[:notice] = 'Requested user id successfully'
      redirect_to graphs_path
    else
      flash[:alert] = 'Could not request user id'
      render :new
    end
  end

  private

  def load_data
    return [] if current_user.facebook_id.nil?

    uri = URI("https://graph.facebook.com/v2.7/#{current_user.facebook_id}")
    params = { fields: 'name,friends', access_token: current_user.facebook_key }
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get(uri)
    @response = response
    JSON.parse(response)
  end
end
