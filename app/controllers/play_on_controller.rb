class PlayOnController < ApplicationController
	#before_filter :authenticate_user!

	#def index
	#	@playlist = Playlist.new
	#	flash[:notice] = t(:create_play_on)
	#	render :template => 'play_on/show'
	#end

	def show
		@link = Link.new
		@playlist = Playlist.new
		@playlists = Playlist.find_all_by_user_id(current_user.id)
		render :layout => "playon"
	end

	def playlist
		
	end	


end