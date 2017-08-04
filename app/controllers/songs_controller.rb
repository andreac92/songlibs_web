class SongsController < ActionController::API
  def search
  	options = Song.get_songs param[:title]
  	respond_to :json, { options: options }
  end

  def get_songlib

  end

end
