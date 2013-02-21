class PlaylistsController < ApplicationController
  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlists }
    end
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    @playlist = Playlist.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/new
  # GET /playlists/new.json
  def new
    @playlist = Playlist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
    @playlist = Playlist.find(params[:id])
    @playlist.name = params[:name]
    @playlist.save



    respond_to do |format|
        if @playlist.save
          format.html { redirect_to "/play_on", notice: 'Playlist was successfully edited.' }
          format.json { render json: @playlist, status: :created, location: @playlist }
        else
          format.html { render action: "edit" }
          format.json { render json: @playlist.errors, status: :unprocessable_entity }
        end
      end
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(params[:playlist])
    @playlist.user = current_user
    
      if request.xhr?
      # respond to Ajax request
        if @playlist.save
            @playlists = Playlist.find_all_by_user_id(current_user.id)
            render :partial => "playlists/shared/index", :locals => {:playlists => @playlists}, :layout => false, :status => :created
        end    
    else
      respond_to do |format|
        if @playlist.save
          format.html { redirect_to "/play_on", notice: 'Playlist was successfully created.' }
          format.json { render json: @playlist, status: :created, location: @playlist }
        else
          format.html { render action: "new" }
          format.json { render json: @playlist.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  # PUT /playlists/1
  # PUT /playlists/1.json
  def update
    @playlist = Playlist.find(params[:id])
    @playlist.name = params[:name]

    respond_to do |format|
      if @playlist.update_attributes(params[:playlist])
        format.html { redirect_to "/play_on", notice: 'Playlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist = Playlist.find(params[:id])
    @play_link = PlaylistLink.find_all_by_playlist_id(params[:id]) 
    @links = @playlist.links.each do |l|
        l.destroy 
    end
    @play_link.each do |f|
      f.destroy
    end   
    #authorize! :destroy, @playlist, @links
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to "/play_on" }
      format.json { head :no_content }
    end
  end
end
