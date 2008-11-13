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
	    expire_caches  
	    render :text => "Song Inserted"
	  rescue StandardError => e
      render :text => e.to_s
    end
	 
	end

  protected	
	
	def check_key
	  @user = User.find_by_crypted_password(params[:auth]) || access_denied
	end
	
	def expire_caches
	  for site in Site.find(:all)
	    site.cached_pages.each { |p| self.class.expire_page(p.url) }
      CachedPage.expire_pages site, site.cached_pages
	  end
	end
	
end
