require 'soundcloud'
require 'open-uri'
require 'rubygems'
require 'json'

class SoundsController < ApplicationController

  # def show
  #   client_playlist = Soundcloud.new(:client_id => Rails.application.secrets.soundcloud_client_id,
  #                       :client_secret => Rails.application.secrets.soundcloud_secret,
  #                       :username => Rails.application.secrets.soundcloud_username,
  #                       :password => Rails.application.secrets.soundcloud_password)
  #   client_track = SoundCloud.new(:client_id => Rails.application.secrets.soundcloud_client_id)
  #   track_url_array = Post.find(params[:id]).try(:track_url)
  #   embed_info = client_track.get('/oembed', :url => track_url_array)
  #   @song = embed_info['html']
  #   @track_id = client_track.get('/resolve', :url => track_url_array).id

  # end

end
