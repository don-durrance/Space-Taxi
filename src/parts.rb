class Part < Actor
  attr_accessor :offset_x_left, :offset_x_right, :offset_y_left, :offset_y_right

end

class TaxiBlower < Part

 has_behaviors :animated, :updatable, :physical => {:shape => :circle,
    :radius => 3,
  :angle => -1.57079633,
  :mass => 50
  }

  OFFSET_X_LEFT = -15
  OFFSET_X_RIGHT = 15
  OFFSET_Y = -9

  def self.offset_x(direction)
    if direction == :left then OFFSET_X_LEFT else OFFSET_X_RIGHT end
  end

  def self.offset_y(direction)
    OFFSET_Y
  end
end

class TaxiHood < Part
 has_behaviors :animated, :updatable, :physical => {:shape => :circle,
    :radius => 3,
  :angle => -1.57079633,
  :mass => 50
  }
  OFFSET_X_LEFT = -15
  OFFSET_X_RIGHT = 15
  OFFSET_Y = -4
  def self.offset_x(direction)
    if direction == :left then OFFSET_X_LEFT else OFFSET_X_RIGHT end
  end

  def self.offset_y(direction)
    OFFSET_Y
  end


end

class TaxiMidsection < Part
 has_behaviors :animated, :updatable, :physical => {:shape => :circle,
    :radius => 3,
  :angle => -1.57079633,
  :mass => 50
  }
  OFFSET_X_LEFT = 1
  OFFSET_X_RIGHT = -1
  OFFSET_Y = -5
  def self.offset_x(direction)
    if direction == :left then OFFSET_X_LEFT else OFFSET_X_RIGHT end
  end

  def self.offset_y(direction)
    OFFSET_Y
  end
end

class TaxiTail < Part
 has_behaviors :animated, :updatable, :physical => {:shape => :circle,
    :radius => 3,
  :angle => -1.57079633,
  :mass => 50
  }
  OFFSET_X_LEFT = 23
  OFFSET_X_RIGHT = -23
  OFFSET_Y = -4
  def self.offset_x(direction)
    if direction == :left then OFFSET_X_LEFT else OFFSET_X_RIGHT end
  end

  def self.offset_y(direction)
    OFFSET_Y
  end
end

class TaxiRearsection < Part
 has_behaviors :animated, :updatable, :physical => {:shape => :circle,
    :radius => 3,
  :angle => -1.57079633,
  :mass => 50
  }
  OFFSET_X_LEFT = 9
  OFFSET_X_RIGHT = -9
  OFFSET_Y = -5
  def self.offset_x(direction)
    if direction == :left then OFFSET_X_LEFT else OFFSET_X_RIGHT end
  end

  def self.offset_y(direction)
    OFFSET_Y
  end
end

