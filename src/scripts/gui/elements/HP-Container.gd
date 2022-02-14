extends Control
#get progress bars
onready var def=$Character/DEFBar
onready var hp=$Character/HPBar
onready var mana=$Character/MANABar

onready var ownr=$Owner

#whose containers are these
export(int, "Kevin", "Quinton", "Charlie", "Bella") var who setget set_who, get_who

func _ready():
  FileMan.connect("upd_cur_stats", self, "update_stats_shown")
  hp.setup()
  def.setup()
  mana.setup()
  
func update_stats_shown():
  hp.valbar.value = FileMan.data.get(get_who().to_lower())["HP"]
  def.valbar.value = FileMan.data.get(get_who().to_lower())["DEF"]
  mana.valbar.value = FileMan.data.get(get_who().to_lower())["MANA"]
  pass

#TODO: figure out a better way to do this
func get_who() -> String:
  match who:
    0:
      return "Kevin"
    1:
      return "Quinton"
    2:
      return "Charlie"
    3:
      return "Bella"
  return "" #unreachable

func set_who(value):
  # NOTE: THIS ISN'T PARTICULARLY EFFICIENT. [TOO BAD!]
  var atlas = AtlasTexture.new()
  atlas.atlas = load("res://assets/characters/hp-cont.png")
  atlas.region.size=Vector2(25,25)
  $Owner.texture=atlas
  $Owner.texture.region.position.x=value*25
  var atlaschar = AtlasTexture.new()
  atlaschar.atlas = load("res://assets/gui/HP-container.png")
  atlaschar.region.size=Vector2(69,60)
  $Character.texture=atlaschar
  $Character.texture.region.position.x=value*69
