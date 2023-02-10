tool
class_name CurveFollower extends VesselBase

var curvefollow: Curve2D
# var followpoints
# var followindex := 0

# func targetAdd(pos: Vector2, mtn: int) -> void:
#   curvefollow.add_point(pos)
#   motion = mtn
#   return

# func follow() -> void:
#   if curvefollow.get_point_count(): # if we even have anything to follow
#     followpoints = curvefollow.get_baked_points() #let's get all points we can go to
#     var tgt = followpoints[followindex] #let's follow the first point and go from there
#     if position.distance_to(tgt) > 18: #wait for the player to get a bit far
#       #vector math
#       movedir = tgt - position
#     else:
#       followindex += 1
#       if followindex >= followpoints.size():
#         followindex = 0
#         curvefollow = null
#         movedir = Vector2.ZERO
#   return

func _ready() -> void:
  curvefollow = Curve2D.new()
  return
