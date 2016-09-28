class GraphsController < ApplicationController
  def index
    @friends = load_friends
  end

  def create
  end

  private

  def load_friends
    return [] if current_user.facebook_id.nil?
    http = Net::HTTP.new('elastic', 9200)
    response = http.get("https://graph.facebook.com/v2.7/#{current_user.facebook_id}?fields=friends", document)
    if response.code == '200'
      JSON.parse(response.body)['friends']['data']
    end
  end
end
