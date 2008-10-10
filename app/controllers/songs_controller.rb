class SongsController < ApplicationController	
	
	before_filter :check_key, :only => :create
	layout nil

	unloadable
	 
	def index
	 #render :text => "music"
	end
	
	def create
	  @song = Song.new(params[:song])
	  @song.user = @user
  
	  begin
	    @song.save
	    render :text => "Song Inserted"
	  rescue StandardError => e
      render :text => e.to_s
    end
	 
	end

  protected	
	
	def check_key
	  @user = User.find_by_crypted_password(params[:auth]) || access_denied
	end
	
end
