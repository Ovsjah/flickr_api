module StaticPagesHelper
  def url(photo)
    if photo.respond_to? :url_c
      photo.url_c
    elsif photo.respond_to? :url_o
      photo.url_o
    else
      "http://farm#{photo.farm}.static.flickr.com/#{photo.server}/#{photo.id}_#{photo.secret}.jpg"
    end
  end
end
