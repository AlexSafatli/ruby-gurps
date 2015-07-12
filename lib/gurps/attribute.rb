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

    def ST value, opts={}
      BasicAttribute.new opts.update ({ 
        name: "Strength",
        shortened_to: "ST",
        cost_per_level: 10,
        value: value || opts[:value]
      })
    end

    def DX value, opts={}
      BasicAttribute.new opts.update ({ 
        name: "Dexterity",
        shortened_to: "DX",
        cost_per_level: 20,
        value: value || opts[:value]
      })
    end

    def IQ value, opts={}
      BasicAttribute.new opts.update ({ 
        name: "Intelligence",
        shortened_to: "IQ",
        cost_per_level: 20,
        value: value || opts[:value]
      })
    end

    def HT value, opts={}
      BasicAttribute.new opts.update ({ 
        name: "Health",
        shortened_to: "HT",
        cost_per_level: 10,
        value: value || opts[:value]
      })
    end

    def Will value, opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Will",
        shortened_to: "Will",
        cost_per_level: 5,
        value: value || opts[:value]
      })
    end

    def HP value, opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Hit Points",
        shortened_to: "HP",
        cost_per_level: 2,
        value: value || opts[:value]
      })
    end

    def FP value, opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Fatigue Points",
        shortened_to: "FP",
        cost_per_level: 3,
        value: value || opts[:value]
      })
    end

    def Per value, opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Perception",
        shortened_to: "Per",
        cost_per_level: 5,
        value: value || opts[:value]
      })
    end

    def BS value, opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Basic Speed",
        shortened_to: "BS",
        cost_per_level: 20,
        value: value || opts[:value]
      })
    end

    def BM value, opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Basic Move",
        shortened_to: "BM",
        cost_per_level: 5,
        value: value || opts[:value]
      })
    end

    def Dodge opts={}
      SecondaryAttribute.new opts.update ({ 
        name: "Dodge"
      })
    end  

  end

end
