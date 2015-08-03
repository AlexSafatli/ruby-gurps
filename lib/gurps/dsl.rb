require 'gurps/attribute'
require 'gurps/template'
require 'gurps/character'

module GURPS

  class CharacterDSLProxy < Character
    
    include AttributeShorthands
    include TemplateShorthands

  end

  module Characters

    # Domain Specific Language for Character Creation

    def self.make &block
      @character = CharacterDSLProxy.new
      @character.instance_eval(&block)
      @character
    end

  end

  def self.character &block
    Characters.make &block
  end

end