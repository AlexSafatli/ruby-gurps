module GURPS
  class Character

    attr_accessor :char_pts_cost

    def initialize(params)
      @name = params[:name]
      @description = params[:description]
      @basic_attributes = {
        strength: params[:st] || 10,
        dexterity: params[:dx] || 10,
        intelligence: params[:iq] || 10,
        health: params[:ht] || 10
      }
      @secondary_attributes = {
        will: params[:will] || default_will,
        hp: params[:hp] || default_hp,
        fp: params[:fp] || default_fp,
        perception: params[:per] || default_per,
        basic_speed: params[:basic_speed] || default_bs,
        basic_move: params[:basic_move] || default_bm
      }
      @advantages = Array.new
      @disadvantages = Array.new
      @char_pts_cost = 0
      calculate_costs
    end

    def strength() @basic_attributes[:strength] end
    def dexterity() @basic_attributes[:dexterity] end
    def intelligence() @basic_attributes[:intelligence] end
    def health() @basic_attributes[:health] end

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
      end
    end

    private

    def default_will() intelligence end
    def default_hp() strength end
    def default_fp() health end
    def default_per() intelligence end
    def default_bs() (health + dexterity)/4.0 end
    def default_bm() default_bs.to_int end

    def calculate_basic_attributes
      @basic_attributes.each do |attrib,val|
        @char_pts_cost += (val-10) * Character.cost_of(attrib)
      end
    end

    #def calculate_secondary_attributes
    #  @secondary_attributes.each do |attrib,val|
        #@char_pts_cost += (val - )
    #  end
    #end

    def calculate_costs
      calculate_basic_attributes
      #calculate_secondary_attributes
    end

  end
end

GURPS::Character.new name: "Alex", dx: 11