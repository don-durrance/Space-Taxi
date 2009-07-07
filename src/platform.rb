require 'actor'

class Platform < Actor
  has_behaviors :graphical, :physical => {:shape => :poly,
    :fixed => true,
    :verts => [[-66, 13], [66, 13], [66, -14], [-65, -14], ]

  }

  def setup
  end
end


