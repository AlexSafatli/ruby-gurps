require 'gurps/param_accessor'

module GURPS
  class Character

    extend ParamAccessor
    attr_accessor :char_pts_cost, :name, :gender, :race, :description
    hash_accessor :basic_attributes, :strength, :dexterity, :intelligence, :health
    hash_accessor :secondary_attributes, :will, :hp, :fp, :per, :basic_speed, :basic_move, :dodge

    def initialize(params)
      @name = params[:name] || '<No Name>'
      @gender = params[:gender] || '<No Gender>'
      @race = params[:race].downcase || 'human'
      @description = params[:description]
      @basic_attributes = {
        strength: params[:st] || 10,
        dexterity: params[:dx] || 10,
        intelligence: params[:iq] || 10,
        health: params[:ht] || 10
      }
      @secondary_attributes = {
        will: params[:will] || default_for(:will),
        hp: params[:hp] || default_for(:hp),
        fp: params[:fp] || default_for(:fp),
        per: params[:per] || default_for(:per),
        basic_speed: params[:basic_speed] || default_for(:basic_speed),
        basic_move: params[:basic_move] || default_for(:basic_move),
        dodge: default_for(:dodge)
      }
      @advantages = Array.new
      @disadvantages = Array.new
      @skills = Array.new
      @char_pts_cost = 0
      calculate_costs
    end

    def self.cost_of(attrib)
      case attrib
      when :strength
        10
      when :dexterity
        20
      when :intelligence
        20
      when :health
        10
      when :will
        5
      when :hp
        2
      when :fp
        3
      when :per
        5
      when :basic_speed
        20
      when :basic_move
        5
      end
    end

    def default_for(attrib)
      case attrib
      when :will
        intelligence
      when :per
        intelligence
      when :hp
        strength
      when :fp
        health
      when :basic_speed
        (health + dexterity)/4.0
      when :basic_move
        (health + dexterity)/4
      when :dodge
        (health + dexterity)/4 + 3
      end
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
        @char_pts_cost += (val-10) * Character.cost_of(attrib)
      end
    end

    def calculate_secondary_attributes
      @secondary_attributes.each do |attrib,val|
        unless attrib == :dodge
          @char_pts_cost += (val - default_for(attrib)) * Character.cost_of(attrib)
        end
      end
    end

    def calculate_costs
      calculate_basic_attributes
      calculate_secondary_attributes
    end

  end
end