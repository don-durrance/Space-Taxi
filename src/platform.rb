require 'actor'

class Platform < Actor
  has_behaviors :graphical, :physical => {:shape => :poly,
    :fixed => true,
    :verts => [[-66.5,-14],[-66.5,14],[66.5,14],[66.5,-14]]
  }

  def setup
  end
end


