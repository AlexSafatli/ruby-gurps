# Meant to be a generic object representing an attribute, skill, advantage, 
# disadvantage, or any "property" that has an associated character point value 
# attached to it.

module GURPS
  class Property

    attr_accessor :name, :description, :level, :cost_per_level

    def initialize(params)
      @name = params[:name] || 'Unnamed'
      @description = params[:description]
      @short_notation = params[:shortened_to] || @name
      @default_value = params[:default]
      @current_value = params[:value] || @default_value
      @level = params[:level] || 1
      @cost_per_level = params[:cost_per_level] || 0
    end

    def default
      @default_value
    end

    def value
      @current_value
    end

    def cost
      @level * @cost_per_level
    end

  end
end