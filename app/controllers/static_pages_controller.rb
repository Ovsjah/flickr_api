class StaticPagesController < ApplicationController
  def home
    flickr = FlickRaw::Flickr.new
    @photos = flickr.photos.search(user_id: params[:flickr][:user_id]) if params[:flickr]
  end
end
