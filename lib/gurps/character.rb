require 'gurps/param_accessor'
require 'gurps/attribute'

module GURPS
  class Character

    include AttributeHandlers

    attr_accessor :name, :gender, :race, :job, :description, :templates

    def initialize(params)
      @name = params[:name] || '<No Name>'
      @gender = params[:gender]
      @race = params[:race] || 'Human'
      @job = params[:job] || 'Commoner'
      @description = params[:description]
      @strength = params[:st]
      @dexterity = params[:dx]
      @intelligence = params[:iq]
      @health = params[:ht]
      @will = params[:will]
      @hp = params[:hp]
      @fp = params[:fp]
      @perception = params[:per]
      @basic_speed = params[:basic_speed]
      @basic_move = params[:basic_move]
      @templates = Array.new
      @advantages = Array.new
      @disadvantages = Array.new
      @skills = Array.new
      @char_pts_cost = 0
    end

    def get_property(property_name)
      property_name = property_name.downcase if property_name.methods.include? :downcase
      property_sym = property_name.to_sym
      if @basic_attributes.has_key?(property_name) || @basic_attributes.has_key?(property_sym)
        @basic_attributes[property_name] || @basic_attributes[property_sym]
      elsif @secondary_attributes.has_key?(property_name) || @secondary_attributes.has_key?(property_sym)
        @secondary_attributes[property_name] || @secondary_attributes[property_sym]
      else
        @skills[@skills.index { |x| x.name.downcase == property_name }] || nil # Make return default.
      end      
    end

    def value_for(property_name)
      prop = get_property property_name
      return unless prop
      unless prop.methods.include? :relative_skill
        prop.value
      else # is a skill
        prop.relative_skill + @basic_attributes[prop.based_on].value
      end
    end

    def add_skill(skill)
      @skills << skill
    end

    def cost
      calculate_costs
      @char_pts_cost
    end

    private

    def calculate_basic_attributes
      @basic_attributes.each do |sym,attrib|
        @char_pts_cost += attrib.cost
      end
    end

    def calculate_secondary_attributes
      @secondary_attributes.each do |sym,attrib|
        unless sym == :dodge
          @char_pts_cost += attrib.cost
        end
      end
    end

    def calculate_skills
      @skills.each { |s| @char_pts_cost += s.char_pts }
    end

    def calculate_costs
      calculate_basic_attributes
      calculate_secondary_attributes
      calculate_skills
    end

  end
end