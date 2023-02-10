class_name Save extends Resource

export(Array, Resource) var mods     = []
export(String) var name              = ""
export(Dictionary) var inv           = {}
export(PackedScene) var location#     = load("res://scenes/game/maps/Meteora.tscn")
export(String) var locationName      = ""
export(Image) var preview            = Image.new()

# stats
export(int, 0, 999999) var money     = 100
export(int) var itemsCollected       = 0
export(int) var playtime             = 0
