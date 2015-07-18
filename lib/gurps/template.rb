module GURPS

  class Template

    @modifiers = []

    def initialize name
      @name = name
    end

    def << modifier
      @modifiers << modifier
    end

    def applyTo char
      # Apply this template to a GURPS character.
      @modifiers.each do |modifier|
        modifier.applyTo char
      end
      char.templates << self
    end

  end

  class PropertyModifier

    def initialize prop, modifier, op="add"
      @property = prop
      @modifier = modifier
      @operator = op
    end

    def applyTo char
      if prop = char.try(@property.to_sym)
        case @operator
        when "add" then prop += @modifier
        when "mult" then prop *= @modifier
        end
      end
    end

  end

  module TemplateShorthands

    # @todo Fill this in.
    def template
    end

  end

end
