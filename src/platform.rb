require 'actor'

class Platform < Actor
  has_behaviors :graphical, :physical => {:shape => :poly,
    :fixed => true,
    :verts => [[-67, 15], [67, 15], [67, -15], [-67, -15] ]

  }

  def setup
  end
end


