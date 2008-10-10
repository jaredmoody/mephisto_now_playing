module Mephisto
  module Plugins
    class NowPlaying
      class Schema < ActiveRecord::Migration
        def self.install
          create_table :songs do |t|
            t.column "user_id",    :integer
            t.column "img",        :string,   :limit => 100
            t.column "title",      :string,   :limit => 75
            t.column "album",      :string,   :limit => 50
            t.column "artist",     :string,   :limit => 50
            t.column "created_at", :datetime, :null => false
            t.column "url",        :string
          end
        end
        
        def self.uninstall
          drop_table :songs
        end
      end
    end
  end
end