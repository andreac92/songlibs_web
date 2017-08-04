class Song < ActiveRecord::Base
  def get_songs title
  	songs = []
  	results = Genius.new.search title
  	if !results.present?
  		return songs
  	end

  	results.response.hits.each do |result|
  		if result.type == 'song'
  			songs << { title: result.result.full_title, path: result.result.path }
  		end
  	end

  	songs
  end

  def get_songlib path
  	source = Genius.new.scrape path
  	page = Nokogiri::HTML(source)
  	
  	lyrics = page.css('div.lyrics section').text

  	lyrics.gsub!(/<a.+>(.+)<\/a>/, $1)
  	lyrics.gsub!(/<i.+>(.+)<\/i>/, $1)
  	lyrics.gsub!(/<span.+>(.+)<\/span>/, $1)

  end


end