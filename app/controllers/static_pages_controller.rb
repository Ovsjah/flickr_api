class StaticPagesController < ApplicationController
  def home
    if params[:flickr]
      get_flickr
      @collected_photos = Kaminari.paginate_array(collect_all).page(params[:page]).per(500)
    end
  rescue FlickRaw::FailedResponse
    flash.now[:danger] = 'Sorry, but the user does not exist.'
    render :home
  end

  private

    def get_flickr
      @flickr = FlickRaw::Flickr.new
    end

    def get_photos(page)
      @flickr.photos.search(
        user_id: params[:flickr][:user_id],
        page: page, per_page: 500,
        extras: :url_c
      )
    end

    def photos_count
      @flickr.people.getInfo(user_id: params[:flickr][:user_id]).photos.count
    end

    def pages_count
      (photos_count / 500.0).ceil
    end

    def collect_all
      photos = []

      pages_count.times do |page|
        photos += get_photos(page + 1).to_a
      end

      photos
    end
end
