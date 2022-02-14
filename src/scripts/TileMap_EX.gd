tool
extends TileMap

#export(bool) var CliffManager
#export(int) var CliffHeight

#var neighbor_array = [Vector2(1,0), Vector2(-1, 0)]

#func update_cliffs(build : bool) -> void:
#  if CliffManager:
#    var cur_cell = world_to_map(get_local_mouse_position())
#    if build:
#      for tile in range(1, CliffHeight):
#        var cur_tile_upd = cur_cell + Vector2(0, tile)
#        add_cliff(cur_tile_upd, $Cliffs)
#      add_cliff(cur_cell + Vector2(0, CliffHeight), $Base)
#    else:
#      for tile in range(1,CliffHeight):
#        var cur_tile_upd = cur_cell + Vector2(0, tile)
#        delete_cliff(cur_tile_upd, $Cliffs)
#      delete_cliff(cur_cell + Vector2(0, CliffHeight), $Base)

#func add_cliff(coord, map):
#  var newtile:int=0
