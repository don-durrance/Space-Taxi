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

  has_behaviors :animated, :updatable, :physical => {:shape => :circle,
    :mass => 125,
    :friction => 1.7,
    :angle => -1.57079633,
    :radius => 10}

  def setup
    self.action = :idle_right
    @facing_dir = :right
    @speed = 50
    @max_speed = 800
    @left_vec = vec2(-@speed,0)
    @right_vec = -@left_vec
    i = input_manager

    i.reg KeyDownEvent, K_UP do
      @moving_up = true
    end

    i.reg KeyDownEvent, K_LEFT do
      @facing_dir = :left
      @moving_left = true
    end

    i.reg KeyDownEvent, K_RIGHT do
      @facing_dir = :right
      @moving_right = true
    end

    i.reg KeyUpEvent, K_UP do
      @moving_up = false
    end

    i.reg KeyUpEvent, K_LEFT do
      @moving_left = false
    end

    i.reg KeyUpEvent, K_RIGHT do
      @moving_right = false
    end

  end

  def moving_up?;@moving_up;end
  def moving_left?;@moving_left;end
  def moving_right?;@moving_right;end

  def update_action
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

  def update(time)
    update_action
    move_up time if moving_up?
    move_right time if moving_right?
    move_left time if moving_left?
    enforce_limits time
  end

  def enforce_limits(time)
    physical.body.a = -1.57079633
    physical.body.w -= 30 if physical.body.w > 2.5
    if physical.body.v.length > @max_speed
      physical.body.apply_impulse(-physical.body.v*time, ZeroVec2)
    end
  end

  def move_up(time)
    move_vec = physical.body.rot*time*@speed
    physical.body.apply_impulse(move_vec, ZeroVec2)
  end

  def move_left(time)
    physical.body.apply_impulse(@left_vec*time, ZeroVec2)
  end

  def move_right(time)
    @facing_dir = 'right'
    physical.body.apply_impulse(@right_vec*time, ZeroVec2)
  end


end
