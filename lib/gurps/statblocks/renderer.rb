require 'erb'

module GURPS
  module Statblocks
    module Renderer
      include ERB::Util
      def render(opts={with: 'data/templates/render.html.erb'})
        template_str = File.read(opts[:with])
        renderer = ERB.new(template_str).result(binding)
        File.open(opts[:file],'w+') { |f| f.write(renderer) }
      end
    end
  end
end