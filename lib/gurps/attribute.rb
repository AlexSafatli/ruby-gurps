# Definitions for basic and secondary attributes.

module GURPS

  class Attribute < Property

    def initialize(params)
      super params
      @level = (value - default)
    end

  end

  class BasicAttribute < Attribute

    def initialize(params)
      params[:default] = 10 
      super params
    end

  end

  class SecondaryAttribute < Attribute

    def initialize(params)
      @based_on = params[:based_on]
      @default = @based_on.value
      super params
    end

  end

end
