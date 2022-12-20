class RecommendationsController < ApplicationController
  def view
    @b =[]
    if current_user.favourites.all.count > 0
      a = []
      current_user.favourites.each do |favourite|
        a.push(RSpotify::Artist.search(favourite.album.artist).first.id)
      end
      avenger = RSpotify::Recommendations.generate(limit: 20, seed_artists: a)
      @b.push("https://open.spotify.com/embed/track/#{avenger.tracks.first.id}?utm_source=generator")
      @b.push("https://open.spotify.com/embed/track/#{avenger.tracks.second.id}?utm_source=generator")
      @b.push("https://open.spotify.com/embed/track/#{avenger.tracks.third.id}?utm_source=generator")
      @b.push("https://open.spotify.com/embed/track/#{avenger.tracks.fourth.id}?utm_source=generator")
      @b.push("https://open.spotify.com/embed/track/#{avenger.tracks.fifth.id}?utm_source=generator")
    end
  end
end
