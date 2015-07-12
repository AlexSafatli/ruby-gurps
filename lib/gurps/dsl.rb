require 'gurps/attribute'

module GURPS

  class CharacterDSLDefinitionProxy
    include AttributeShorthands
  end

  module CharacterDSL

    # Domain Specific Language for Character Creation

    def self.define &block
      proxy = CharacterDSLDefinitionProxy.new
      proxy.instance_eval(&block)
    end

  end

end