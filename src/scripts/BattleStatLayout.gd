extends HBoxContainer

onready var hpkev = $HPKevin
onready var hpquin = $HPQuinton
onready var hpcharlie = $HPCharlie
onready var hpbella = $HPBella

func _process(_delta):
  if FileMan.tempdata.has("Kevin"):
      var kevindata=FileMan.tempdata["Kevin"]
      hpkev.hp.max_value=kevindata["maxHP"]
      hpkev.def.max_value=kevindata["maxDEF"]
      hpkev.hp.value=kevindata["HP"]
      hpkev.def.value=kevindata["DEF"]
      hpkev.mana.value=kevindata["MANA"]
      hpkev.mana.max_value=kevindata["maxMANA"]
