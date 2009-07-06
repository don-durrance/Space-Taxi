require 'actor'

class LeftWall < Actor
  has_behaviors :physical => {:shape => :poly,
    :fixed => true,
    :verts => [[0,0],[0,768],[1,768],[1,0]]}
end

class RightWall < Actor
  has_behaviors :physical => {:shape => :poly,
    :fixed => true,
    :x => 1023,
    :y => 0,
    :verts => [[0,0],[0,768],[1,768],[1,0]]}
end


class TopWall < Actor
  has_behaviors :physical => {:shape => :poly,
    :fixed => true,
    :verts => [[0,0],[0,1],[1024,1],[1024,0]]}
end

class BottomWall < Actor
  has_behaviors :physical => {:shape => :poly,
    :fixed => true,
    :x => 0,
    :y => 767,
    :verts => [[0,0],[0,1],[1024,1],[1024,0]]}
end


