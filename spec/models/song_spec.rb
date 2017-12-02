require "rails_helper"

RSpec.describe Song do

  it "returns list of songs based on search term" do
    song = Song.new
    results = song.get_songs 'best american girl'

    expect(results).to be_an(Array)
    expect(results).to include({:title=>"Your Best American Girl by Mitski",
                                :path=>"/Mitski-your-best-american-girl-lyrics"})
  end

  it 'returns the lyrics of a chosen song' do
    song = Song.new
    lyrics = song.get_lyrics '/Mitski-your-best-american-girl-lyrics'

    expect(lyrics).to be_a(String)
    expect(lyrics).not_to eql('')
    expect(lyrics).to match(/Your mother wouldn\'t approve of how my mother raised me/)
  end
end
