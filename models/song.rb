class Song < ActiveRecord::Base

    validates_presence_of :title 
    validates_presence_of :album
	  validates_presence_of :artist
	  
	  belongs_to :user
	
	def after_create
		require "AlbumArt"
		art = AlbumArt.new(self.artist, self.album)
		art.find
		self.img = art.img
		self.url = art.url
		self.save
	end
end
