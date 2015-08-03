# Definitions for basic and secondary attributes.

require 'gurps/property'

module GURPS

  class Attribute < Property

    def initialize(params)
      super params
      @level = value - default
    end

  end

  class BasicAttribute < Attribute

    def initialize(params)
      params[:default] ||= 10
      super params
    end

  end

  class SecondaryAttribute < Attribute

    def initialize(params)
      @based_on = params[:based_on]
      params[:default] ||= @based_on ? @based_on.value : 10
      super params
    end

  end

  module AttributeHandlers

    def strength
      BasicAttribute.new ({ 
        name: "Strength",
        shortened_to: "ST",
        cost_per_level: 10,
        value: @strength
      })
    end

    def dexterity
      BasicAttribute.new ({ 
        name: "Dexterity",
        shortened_to: "DX",
        cost_per_level: 20,
        value: @dexterity
      })
    end

    def intelligence
      BasicAttribute.new ({ 
        name: "Intelligence",
        shortened_to: "IQ",
        cost_per_level: 20,
        value: @intelligence
      })
    end

    def health
      BasicAttribute.new ({ 
        name: "Health",
        shortened_to: "HT",
        cost_per_level: 10,
        value: @health
      })
    end

    def will
      SecondaryAttribute.new ({ 
        name: "Will",
        shortened_to: "Will",
        cost_per_level: 5,
        value: @will,
        based_on: intelligence
      })
    end

    def hp
      SecondaryAttribute.new ({ 
        name: "Hit Points",
        shortened_to: "HP",
        cost_per_level: 2,
        value: @hp,
        based_on: strength
      })
    end

    def fp
      SecondaryAttribute.new ({ 
        name: "Fatigue Points",
        shortened_to: "FP",
        cost_per_level: 3,
        value: @fp,
        based_on: health
      })
    end

    def perception
      SecondaryAttribute.new ({ 
        name: "Perception",
        shortened_to: "Per",
        cost_per_level: 5,
        value: @perception,
        based_on: intelligence
      })
    end

    def basic_speed
      SecondaryAttribute.new ({ 
        name: "Basic Speed",
        shortened_to: "BS",
        cost_per_level: 20,
        value: @basic_speed,
        default: (health + dexterity)/4.0
      })
    end

    def basic_move
      SecondaryAttribute.new ({ 
        name: "Basic Move",
        shortened_to: "BM",
        cost_per_level: 5,
        value: @basic_move,
        default: (health + dexterity)/4
      })
    end

    def dodge
      SecondaryAttribute.new ({ 
        name: "Dodge",
        default: (health + dexterity)/4 + 3
      })
    end  

  end

  module AttributeShorthands

    def ST val
      @strength = val
    end

    def DX val
      @dexterity = val
    end

    def IQ val
      @intelligence = val
    end

    def HT val
      @health = val
    end

    def Will val
      @will = val
    end

    def HP val
      @hp = val
    end

    def FP val
      @fp = val
    end

    def Per val
      @perception = val
    end

    def BS val
      @basic_speed = val
    end

    def BM val
      @basic_move = val
    end

    def Dodge val
    end

  end

end
