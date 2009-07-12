require 'actor'

class Platform < Actor
  attr_accessor :spawn_point_x, :spawn_point_y
  def setup
    @spawn_point_x = -10
    @spawn_point_y = -10
  end
  has_behaviors :graphical, :physical => {:shape => :poly,
    :fixed => true,
    :verts => [[-67, 15], [67, 15], [67, -15], [-67, -15] ]

  }


end


