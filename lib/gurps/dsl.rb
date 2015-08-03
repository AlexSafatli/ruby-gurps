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

    def self.make name, &block
      @character = CharacterDSLProxy.new { name: name }
      @character.instance_eval(&block)
      @character
    end

  end

  def self.character name, &block
    Characters.make name, &block
  end

end