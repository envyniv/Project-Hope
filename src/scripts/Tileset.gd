
tool
extends TileSet

const GRASS = 0
const DIRT = 2
const PATH = 4

const MOUNTAINTOP = 8
const ROCK = 12
const ROCK_PATH = 11

var binds = {
  #GRASS: [DIRT],
  DIRT : [GRASS],
  #MOUNTAINTOP : [ROCK],
  ROCK : [MOUNTAINTOP],
}

func _is_tile_bound(drawn_id, neighbor_id):
  if drawn_id in binds:
    return neighbor_id in binds[drawn_id]
  return false
