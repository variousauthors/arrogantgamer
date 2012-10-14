module Jekyll

  class Playlist < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)

      output = "<ul id='playlist'>"
      playlist = YAML.load_file(File.expand_path("../../_playlist.yaml"))
      playlist['games'].each do |game| 
        output += "<li class='game'><a href=" + game['url'] + ">" + game['name'] + "</a></li>"
      end

      output += "</ul>"
    end

  end

end

Liquid::Template.register_tag('play_list', Jekyll::Playlist)
