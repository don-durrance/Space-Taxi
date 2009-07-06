#require 'level'
#require 'ftor'
require 'physical_level'

class DemoLevel < PhysicalLevel
  def setup
    space.gravity = vec2(0,200)
    @my_actor = create_actor :taxi, :x => 300, :y => 300

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

