module GURPS
  class Skill
    attr_accessor :name, :description, :based_on, :difficulty, :relative_skill, :char_pts
    def initialize(params)
      @name = params[:name]
      @description = params[:description]
      @based_on = params[:based_on]
      @difficulty = params[:difficulty]
      unless params[:relative_skill].nil? and params[:char_pts].nil?
        @char_pts = params[:char_pts]
        @relative_skill = params[:relative_skill]
      else
        raise 'Relative skill and character points both nil.'
      end
      if @char_pts.nil? 
        calculate_costs
      end
      if @relative_skill.nil?
        calculate_skill_level
      end
    end

    def self.starting_modifier_for(difficulty)
      case difficulty
      when :very_hard
        -3
      when :hard
        -2
      when :average
        -1
      when :easy
        0
      end
    end

    private
    def calculate_skill_level
      level = 0
      while level < @char_pts
        level += 1
        case
        when (level == 1)
          @relative_skill = Skill.starting_modifier_for(@difficulty)
        when (level == 2), (level % 4 == 0)
          @relative_skill += 1
        end
      end
    end

    def calculate_costs
      level = Skill.starting_modifier_for(@difficulty) - 1
      cost_addition = 0
      while level < @relative_skill
        level += 1
        case cost_addition
        when 0, 1
          cost_addition += 1
        when 2
          cost_addition += 2
        else
          cost_addition += 4
        end
      end
      @char_pts = cost_addition
    end

  end
end