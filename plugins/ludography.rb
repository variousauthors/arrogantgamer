module Jekyll

  class Ludography < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)

      output = "<ul id='ludography'>"
      playlist = YAML.load_file(File.expand_path("../../_ludography.yaml"))
      playlist['games'].each do |game| 
        unless game['hidden']
          dir = context.registers[:site].config['games_dir']
          output += "<li class='game'><a href='/#{ dir }/#{ game['name'].to_url }'>#{ game['name'] }</a></br>"
          output += "<small>" + game['brief'] + "</small></li>"
        end
      end

      output += "</ul>"
    end

  end

end

Liquid::Template.register_tag('ludography', Jekyll::Ludography)
