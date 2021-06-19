extends HBoxContainer

onready var hpkev = $HPKevin
onready var hpquin = $HPQuinton
onready var hpcharlie = $HPCharlie
onready var hpbella = $HPBella

func _ready():
  update()

#TODO: use FileMan.data as a resource, tempdata is obsolete, as now there are predefined saves
#      as explained in SaveFile.gd
#      also use signals to trigger this, don't just slam it into _process
func update():
  if "Kevin" in FileMan.data.party:
    hpkev.show()
  if "Quinton" in FileMan.data.party:
    hpquin.show()
  if "Charlie" in FileMan.data.party:
    hpcharlie.show()
  if "Bella" in FileMan.data.party:
    hpbella.show()
    
  if FileMan.data.kevin != {}:
      var kevindata = FileMan.data.kevin
      hpkev.hp.max_value = kevindata["maxHP"]
      hpkev.def.max_value = kevindata["maxDEF"]
      hpkev.hp.value = kevindata["HP"]
      hpkev.def.value = kevindata["DEF"]
      hpkev.mana.value = kevindata["MANA"]
      hpkev.mana.max_value = kevindata["maxMANA"]
  pass
