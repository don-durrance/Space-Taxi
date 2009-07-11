require 'physical_level'
require 'walls'
require 'parts'

class DemoLevel < PhysicalLevel
  def setup
    space.gravity = vec2(0,100)
    @taxi = create_actor :taxi, :x => 300, :y => 300

    left_wall = create_actor :left_wall, :view => false
    top_wall = create_actor :top_wall, :view => false
    right_wall = create_actor :right_wall, :view => false
    bottom_wall = create_actor :bottom_wall, :view => false
    @platform1 = create_actor :platform, :x => 300, :y => 400
    man = create_actor :man, :x => 300, :y => 367

    space.add_collision_func(:platform, :taxi) do |p,t|
      unless @taxi.dying then
        @taxi.dying = true
        create_taxi_parts(@taxi.facing_dir)
        puts @taxi.facing_dir
        @taxi.die
      end
    end

    space.add_collision_func(:platform, [:taxi_left_gear, :taxi_right_gear]) do |p,t|
      if @taxi.gear_down? && @taxi.can_survive? then
        @taxi.land
      else
        unless @taxi.dying then
        @taxi.dying = true
      create_taxi_parts(@taxi.facing_dir)
      puts @taxi.facing_dir
        @taxi.die
        end
      end

    end


      @stars = []
      20.times { @stars << Ftor.new(rand(viewport.width),rand(viewport.height)) }
    end

    def draw(target, x_off, y_off)
      target.fill [25,25,25,255]
      for star in @stars
        target.draw_circle_s([star.x,star.y],1,[255,255,255,255])
      end
    end

    def create_taxi_parts(direction)
      taxi_parts = {
      'TaxiHood' => 'taxi_hood', 
      'TaxiBlower' => 'taxi_blower',
      'TaxiMidsection' => 'taxi_midsection',
      'TaxiTail' => 'taxi_tail',
      'TaxiRearsection' => 'taxi_rearsection'
      }
      taxi_parts.each do |part_class,part|
        part = create_actor part.to_s, :x => eval(part_class).offset_x(direction) + @taxi.x, :y => eval(part_class).offset_y(direction) + @taxi.y
        part.action = direction
      end

    end
end

