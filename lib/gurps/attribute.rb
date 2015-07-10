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

  module AttributeShorthands

    def ST opts={}
      BasicAttribute.new opts.update ({ 
        name: "Strength",
        shortened_to: "ST",
        cost_per_level: 10
      })
    end

    def DX opts={}
      BasicAttribute.new opts.update ({ 
        name: "Dexterity",
        shortened_to: "DX",
        cost_per_level: 20
      })
    end

    def IQ opts={}
      BasicAttribute.new opts.update ({ 
        name: "Intelligence",
        shortened_to: "IQ",
        cost_per_level: 20
      })
    end

    def HT opts={}
      BasicAttribute.new opts.update ({ 
        name: "Health",
        shortened_to: "HT",
        cost_per_level: 10
      })
    end

    def Will opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Will",
        shortened_to: "Will",
        cost_per_level: 5
      })
    end

    def HP opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Hit Points",
        shortened_to: "HP",
        cost_per_level: 2
      })
    end

    def FP opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Fatigue Points",
        shortened_to: "FP",
        cost_per_level: 3
      })
    end

    def Per opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Perception",
        shortened_to: "Per",
        cost_per_level: 5
      })
    end

    def BS opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Basic Speed",
        shortened_to: "BS",
        cost_per_level: 20
      })
    end

    def BM opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Basic Move",
        shortened_to: "BM",
        cost_per_level: 5
      })
    end

    def Dodge opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Dodge"
      })
    end  

  end

end
