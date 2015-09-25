require 'gurps/attribute'
require 'gurps/template'
require 'gurps/character'

module GURPS

  class CharacterProxy < Character
    
    # Shorthands

    include AttributeShorthands
    include TemplateShorthands

  end

  class TemplateProxy < Template

    # Shorthands

    # @todo

  end


  def self.character name, &block
    @character = CharacterProxy.new name: name
    @character.instance_eval(&block)
    @character
  end

  def self.template name, &block
    @template = TemplateProxy.new name 
    @template.instance_eval(&block)
    @template 
  end

end