#
# Author: various.authors
# A different kind of blockquote, based on the work of: Brandon Mathis
#
# Outputs a string nicely dressed up
#
#   {% imagine title %}
#   Wheeee!
#   {% endimagine %}
#   ...
#   <blockquote class='imagine-with-me'>
#     <p>Wheeee!</p>
#   </blockquote>
#
require './plugins/titlecase.rb'

module Jekyll

  class Imagine < Liquid::Block
    FullCiteWithTitle = /(\S.*)\s+(https?:\/\/)(\S+)\s+(.+)/i
    FullCite = /(\S.*)\s+(https?:\/\/)(\S+)/i
    Author =  /(.+)/

    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      quote = paragraphize(super)
      "<blockquote class='imagine-with-me'>#{quote}</blockquote>"
    end

    def paragraphize(input)
      "<p>#{input.lstrip.rstrip.gsub(/\n\n/, '</p><p>').gsub(/\n/, '<br/>')}</p>"
    end
  end
end

Liquid::Template.register_tag('imagine', Jekyll::Imagine)
