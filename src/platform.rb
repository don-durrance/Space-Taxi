require 'actor'

class Platform < Actor
  has_behaviors :graphical, :physical => {:shape => :poly,
    :fixed => true,
    :verts => [[-64,-14],[-64,14],[64,14],[64,-14]]
  }

  def setup
  end
end


