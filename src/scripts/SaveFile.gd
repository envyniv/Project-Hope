extends Resource
class_name Save
#TODO
export(Array, Resource) var mods              = []
export(String) var name                       = "saveEmpty"
export(Resource) var lead                     = load("res://characters/Kevin/kev.tres")
export(Array, Resource) var partyRes          = []
export(Dictionary) var inv                    = {}
export(PackedScene) var location              = load("res://scenes/stage/Meteora.tscn")
export(String) var locationName               = ""
export(int) var playtime                      = 0
export(int, 0, 999999) var money              = 100
export(Image) var preview                     = Image.new()
export(Vector2) var position                  = Vector2.ZERO
export(int) var itemsCollected                = 0
