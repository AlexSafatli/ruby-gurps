require 'gurps/param_accessor'
require 'gurps/attribute'

module GURPS
  class Character

    include AttributeShorthands
    attr_accessor :name, :gender, :race, :job, :description, :templates
    hash_accessor :basic_attributes, :strength, :dexterity, :intelligence, :health
    hash_accessor :secondary_attributes, :will, :hp, :fp, :per, :basic_speed, :basic_move, :dodge

    def initialize(params)
      @name = params[:name] || '<No Name>'
      @gender = params[:gender]
      @race = params[:race] || 'Human'
      @job = params[:job] || 'Commoner'
      @description = params[:description]
      @basic_attributes = {
        strength: ST(params[:st]),
        dexterity: DX(params[:dx]),
        intelligence: IQ(params[:iq]),
        health: HT(params[:ht])
      }
      @secondary_attributes = {
        will: Will(params[:will], based_on: intelligence),
        hp: HP(params[:hp], based_on: strength),
        fp: FP(params[:fp], based_on: health),
        per: Per(params[:per], based_on: intelligence),
        basic_speed: BS(params[:basic_speed], default: (health + dexterity)/4.0),
        basic_move: BM(params[:basic_move], default: (health + dexterity)/4),
        dodge: Dodge(default: (health + dexterity)/4 + 3)
      }
      @templates = Array.new
      @advantages = Array.new
      @disadvantages = Array.new
      @skills = Array.new
      @char_pts_cost = 0
    end

    def value_for(property_name)
      if @basic_attributes.has_key? property_name
        @basic_attributes[property_name].value
      elsif @secondary_attributes.has_key? property_name
        @secondary_attributes[property_name].value
      else
        skill = @skills[@skills.index { |x| x.name == property_name }] || nil # Make return default.
        skill.relative_skill + @basic_attributes[skill.based_on].value if skill
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