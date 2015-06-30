require 'erb'

module GURPS
  module Statblocks
    module Renderer
      include ERB::Util
      def render(opts={with: "templates/statblocks.html.erb"})
        renderer = ERB.new(opts[:with]).result(binding)
        File.open(opts[:file],"w+") { |f| f.write(renderer) }
      end
    end
  end
end