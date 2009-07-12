require 'actor'

class Platform < Actor
  attr_accessor :spawn_point
  def setup
    @spawn_point = {:x => -10, :y => -10}
  end

  has_behaviors :graphical, :physical => {:shape => :poly,
    :fixed => true,
    :verts => [[-67, 15], [67, 15], [67, -15], [-67, -15] ]

  }


end


