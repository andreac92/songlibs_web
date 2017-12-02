class Song
	FILL_IN_NUM = 10
	WORD_TYPES = %w[ noun verb adverb adjective ]
	WORD_FILTERS = %w[ the who ]

	def get_songs title
		songs = []
		results = Genius.new.search title
		if !results.present?
			return songs
		end

		results['response']['hits'].each do |result|
			if result['type'] == 'song'
				songs << { title: result['result']['full_title'], path: result['result']['path'] }
			end
		end
		songs
	end

	def get_lyrics path
		source = Genius.new.scrape path
		page = Nokogiri::HTML(source)

		lyrics = page.css('div.lyrics')[0].text

		lyrics
	end

	def get_songlib
		html_lyrics = get_lyrics
		lyrics = (lyrics.gsub(/<.+>/, '')).split(/\W+/)
		words = get_words lyrics

		{ words: words, lyrics: lyrics }
	end

	def get_words lyrics
		adlib_words = []
		chosen = Set.new
		num = 0

		while num != FILL_IN_NUM do
			# word = lyrics.sample
			# next if word.length < 3 || !chosen.add?(word)

			# word_info = Dictionary.lookup(word.downcase)
			# if !word_info || !WORD_TYPES.include?(word_info.type.downcase)
			# 	next
			# end

			# adlib_words << { word: word, description: word_description(word_info) }
			# num++
		end

		adlib_words
	end
end
