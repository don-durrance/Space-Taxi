require 'actor'

class Man < Actor
  has_behaviors :updatable, :animated => { :frame_update_time => 100 }

  def setup
    self.action = :waving
  end

  def update(time)
    super time
  end


end

