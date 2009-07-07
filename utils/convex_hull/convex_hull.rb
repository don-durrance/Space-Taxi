# Gets vertices for a chipmunk collision body
# prints them for use with gamebox!
#
# Just color the upper left hand corner pixel with your "key" color (only one pixel!), then
# use the same color to draw a single pixel for each vertex on your sprite image
#
# I got the ConvexHull algorithm from http://branch14.org/snippets/convex_hull_in_ruby.html
# The author appears to be uncredited, but thanks dude!

require 'rubygems'
require 'RMagick'

if !ARGV[0] then 
  puts "Usage: convex_hull.rb <image>"
  exit
end

class Point
  def initialize(x,y)
    @x, @y = x,y
  end

  attr_reader :x, :y

  def distance(point)
    Math.hypot(point.x - x, point.y - y)
  end

end 

module ConvexHull

  # after graham & andrew
  def self.calculate(points)
    lop = points.sort_by { |p| p.x }
    left = lop.shift
    right = lop.pop
    lower, upper = [left], [left]
    lower_hull, upper_hull = [], []
    det_func = determinant_function(left, right)
    until lop.empty?
      p = lop.shift
      ( det_func.call(p) < 0 ? lower : upper ) << p
    end
    lower << right
    until lower.empty?
      lower_hull << lower.shift
      while (lower_hull.size >= 3) &&
        !convex?(lower_hull.last(3), true)
        last = lower_hull.pop
        lower_hull.pop
        lower_hull << last
      end
    end
    upper << right
    until upper.empty?
      upper_hull << upper.shift
      while (upper_hull.size >= 3) &&
        !convex?(upper_hull.last(3), false)
        last = upper_hull.pop
        upper_hull.pop
        upper_hull << last
      end
    end
    upper_hull.shift
    upper_hull.pop
    lower_hull + upper_hull.reverse
  end

  private

  def self.determinant_function(p0, p1)
    proc { |p| ((p0.x-p1.x)*(p.y-p1.y))-((p.x-p1.x)*(p0.y-p1.y)) }
  end

  def self.convex?(list_of_three, lower)
    p0, p1, p2 = list_of_three
    (determinant_function(p0, p2).call(p1) > 0) ^ lower
  end

end


include Magick

sprite = ImageList.new(ARGV[0])

# get the key color from the pixel at 0,0
key = sprite.get_pixels(0,0,1,1)
key = key[0]
center = [sprite.columns / 2, sprite.rows / 2]

# erase the key color in memory so it's not detected as a vertex
sprite = sprite.color_point(0,0,'none') 


verts = Array.new
new_verts = Array.new

sprite.each_pixel {|pixel, c, r| verts.push([c,r]) if pixel == key}


verts.each do  |c, r|
  p = Point.new((c.to_i - center[0].to_i), (r.to_i - center[1].to_i))
  new_verts.push(p)
end


final_verts =  ConvexHull.calculate(new_verts)

print ":verts => ["
final_verts.each do |vert|
  print "[#{vert.x}, #{vert.y}], "
end
puts "]"


