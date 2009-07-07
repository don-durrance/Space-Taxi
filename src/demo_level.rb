require 'physical_level'
require 'walls'

class DemoLevel < PhysicalLevel
  def setup
    space.gravity = vec2(0,200)
    @taxi = create_actor :taxi, :x => 300, :y => 300

    left_wall = create_actor :left_wall, :view => false
    top_wall = create_actor :top_wall, :view => false
    right_wall = create_actor :right_wall, :view => false
    bottom_wall = create_actor :bottom_wall, :view => false
    @platform1 = create_actor :platform, :x => 300, :y => 400


    @stars = []
    20.times { @stars << Ftor.new(rand(viewport.width),rand(viewport.height)) }
  end

  def draw(target, x_off, y_off)
    target.fill [25,25,25,255]
    for star in @stars
      target.draw_circle_s([star.x,star.y],1,[255,255,255,255])
    end
  end
end

