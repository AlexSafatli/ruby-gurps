require 'gurps/attribute'
require 'gurps/template'

module GURPS

  class CharacterDSLDefinitionProxy
    include AttributeShorthands
    include TemplateShorthands
  end

  module CharacterDSL

    # Domain Specific Language for Character Creation

    def self.define &block
      proxy = CharacterDSLDefinitionProxy.new
      proxy.instance_eval(&block)
    end

  end

end