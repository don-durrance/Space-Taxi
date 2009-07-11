require 'actor'
require 'publisher'
require 'graphical_actor_view'

class TaxiView < GraphicalActorView
  def draw(target, x_off, y_off)
    #    target.draw_box [@actor.x,@actor.y], [20,20], [240,45,45,255]
    super target, x_off, y_off
  end
end

class Taxi < Actor
  attr_reader :facing_dir
  attr_accessor :dying

  has_behaviors :animated, :updatable, 
    :physical => {
    :shape => :poly,
    :mass => 125,
    :friction => 1.7,
    :verts => [[-29, -15], [-29, 2], [28, 2], [27, -15] ],
    :parts => [ 
      :taxi_right_gear => {:verts => [[7, 3], [9, 11], [18, 11], [12, 3] ], :shape => :poly, :offset => vec2(0,0)  },
      :taxi_left_gear => {:verts => [[-20, 11], [-11, 11], [-8, 3], [-14, 3], ], :shape => :poly, :offset => vec2(0,0) }
  ]

  } 

  def setup
    self.action = :idle_right
    @gear_down = true
    @facing_dir = :right
    @speed = 60
    @max_speed = 900
    @death_speed = 120
    @up_vec = vec2(0,-@speed)
    @left_vec = vec2(-@speed,0)
    @right_vec = -@left_vec
    i = input_manager

    i.reg KeyDownEvent, K_Z do
      if @gear_down then @gear_down = false else @gear_down = true end
    end
  
    i.reg KeyDownEvent, K_UP do
      @moving_up = true
      @landed = false
    end

    i.reg KeyDownEvent, K_LEFT do
      @facing_dir = :left unless landed? || gear_down?
      @moving_left = true 
    end

    i.reg KeyDownEvent, K_RIGHT do
      @facing_dir = :right unless landed? || gear_down?
      @moving_right = true 
    end

    i.reg KeyUpEvent, K_UP do
      @moving_up = false
      @landed = false
    end

    i.reg KeyUpEvent, K_LEFT do
      @moving_left = false
    end

    i.reg KeyUpEvent, K_RIGHT do
      @moving_right = false
    end
  end

  def gear_down?
    @gear_down
  end

  def moving?
    if @moving_left || @moving_right || @moving_up then true end
  end

  def landed?
    @landed
  end

  def land
    @landed = true
  end

  def moving_up?;@moving_up;end
  def moving_left?;@moving_left;end
  def moving_right?;@moving_right;end

  def update_action
    if self.gear_down? && !self.moving_up? then self.action = "landing_#{@facing_dir}".to_sym 
    elsif self.gear_down? && self.moving_up? then
      self.action = "thrust_gear_#{@facing_dir}".to_sym
    else
      if moving_right? && moving_up? then
        self.action = :thrust_up_right
      else 
        if moving_left? && moving_up? then
          self.action = :thrust_up_left
        end
      end
      if !moving_right? && !moving_up? && !moving_left? then
        self.action = "idle_#{@facing_dir}".to_sym
      end
      if moving_left? && !moving_up? then
        self.action = :move_left
      end
      if moving_right? && !moving_up? then
        self.action = :move_right
      end
      if moving_up? && !moving_left? && !moving_right? then
        self.action = "thrust_up_facing_#{@facing_dir}".to_sym
      end

    end
  end



  def update(time)
    update_action
    move_up time if moving_up?
    move_right time if moving_right? && !landed? && !gear_down?
    move_left time if moving_left? && !landed? && !gear_down?
    enforce_limits time
  end

  def enforce_limits(time)
    physical.body.a = 0
    physical.body.w -= 30 if physical.body.w > 2.5
    if physical.body.v.length > @max_speed
      physical.body.apply_impulse(-physical.body.v*time, ZeroVec2)
    end
  end

  def move_up(time)
    physical.body.apply_impulse(@up_vec*time, ZeroVec2)
  end

  def move_left(time)
    physical.body.apply_impulse(@left_vec*time, ZeroVec2)
  end

  def move_right(time)
    @facing_dir = 'right'
    physical.body.apply_impulse(@right_vec*time, ZeroVec2)
  end

  def can_survive?
    if physical.body.v.length <= @death_speed then true end
  end

  def dying?
    @dying
  end

  def die
    @dying = true
    remove_self
  end


end
