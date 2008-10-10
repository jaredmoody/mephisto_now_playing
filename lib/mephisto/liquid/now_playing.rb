module Mephisto
  module Liquid
    class NowPlaying < ::Liquid::Block
      require File.expand_path(File.dirname(__FILE__) + "/../../../models/song")
      require 'liquid'
      Syntax = /(#{::Liquid::TagAttributes}\s?,?\s?)*/

        def initialize(tag_name, markup, tokens)
          super
          if markup =~ Syntax
            @options = parse_options( $1 )
          else
            raise Liquid::SyntaxError.new("Syntax Error in tag 'nowplaying'")
          end
        end
        
      def render(context)
         @user = User.find_by_login(@options[:user]) or raise "couldn't find user #{@options[:user]}"
         @song = Song.find_by_user_id(@user.id, :order => "created_at DESC")
         "<a href='#{@song.url}'><img src='#{@song.img}' height='120', width='120' border='0' /></a><br/> \
         #{@song.title}<br/> \
         <b>from: </b>#{@song.album}<br/><b>by: </b>#{@song.artist}<br/> \
         <b>played on: </b>#{@song.created_at.strftime '%m.%d.%Y'}</b>" if @song
      end
      
      private

      def parse_options(opt_string)
        pairs, opts = opt_string.split(','), {}
        pairs.each do |pair|
          opt, value = pair.split(':')
          opt, value = opt.strip, value.strip
          opts[opt.to_sym] = value
        end
        return opts
      end
      
    end
  end
end