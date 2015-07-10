require 'gurps/param_accessor'
require 'gurps/attribute'

module GURPS
  class Character

    extend ParamAccessor
    attr_accessor :char_pts_cost, :name, :gender, :race, :job, :description
    hash_accessor :basic_attributes, :strength, :dexterity, :intelligence, :health
    hash_accessor :secondary_attributes, :will, :hp, :fp, :per, :basic_speed, :basic_move, :dodge

    def initialize(params)
      @name = params[:name] || '<No Name>'
      @gender = params[:gender]
      @race = params[:race] || 'Human'
      @job = params[:job] || 'Commoner'
      @description = params[:description]
      @basic_attributes = {
        strength: ST(value: params[:st]),
        dexterity: DX(value: params[:dx]),
        intelligence: IQ(value: params[:iq]),
        health: HT(value: params[:ht])
      }
      @secondary_attributes = {
        will: Will(value: params[:will], based_on: intelligence),
        hp: HP(value: params[:hp], based_on: strength),
        fp: FP(value: params[:fp], based_on: health),
        per: Per(value: params[:per], based_on: intelligence),
        basic_speed: BS(value: params[:basic_speed], default: (health + dexterity)/4.0),
        basic_move: BM(value: params[:basic_move], default: (health + dexterity)/4),
        dodge: Dodge(default: (health + dexterity)/4 + 3)
      }
      @advantages = Array.new
      @disadvantages = Array.new
      @skills = Array.new
      @char_pts_cost = 0
      calculate_costs
    end

    def value_for(skill_name)
      skill = @skills[@skills.index { |x| x.name == skill_name }] || nil # Make return default.
      skill.relative_skill + @basic_attributes[skill.based_on]
    end

    def add_skill(skill)
      @skills << skill
      @char_pts += skill.char_pts
    end

    private

    def calculate_basic_attributes
      @basic_attributes.each do |attrib,val|
        @char_pts_cost += attrib.cost
      end
    end

    def calculate_secondary_attributes
      @secondary_attributes.each do |attrib,val|
        unless attrib == :dodge
          @char_pts_cost += attrib.cost
        end
      end
    end

    def calculate_costs
      calculate_basic_attributes
      calculate_secondary_attributes
    end

  end
end