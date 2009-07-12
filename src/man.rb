require 'actor'
require 'publisher'
require 'graphical_actor_view'

class ManView < GraphicalActorView
  def draw(target, x_off, y_off)
    super target, x_off, y_off
  end
end

class Man < Actor
  has_behaviors :updatable, 
    :animated => { :frame_update_time => 100 },
    :physical => { 
    :shape => :poly,
    :verts => [[-3, -9], [-3, 9], [2, 9], [2, -9]],
    :mass => 50
  }

  def setup
    @ttl = 2000
    self.action = :waving
  end

  def update(time)
    if self.dying?
      @ttl -= time
      remove_self if @ttl < 0
    end
    super time
  end


  def dying?
    @dying
  end

  def die
    @dying = true
  end

  def can_survive?
    false
  end



end

