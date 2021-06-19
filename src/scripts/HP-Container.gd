extends Control

#get progress bars
onready var def=$Character/DEFBar
onready var hp=$Character/HPBar
onready var mana=$Character/MANABar

#whose containers are these

export(int, "Kevin", "Quinton", "Charlie", "Bella") var who setget set_who, get_who

#current values
onready var deflabel  = $Character/DEFBar/icon/DEF
onready var hplabel   = $Character/HPBar/icon/HP
onready var manalabel = $Character/MANABar/icon/MANA
#max values
onready var hpmax     = $Character/HPBar/MAXHP
onready var defmax    = $Character/DEFBar/MAXDEF
onready var manamax   = $Character/MANABar/MAXMANA

#colors
export(Color) var lowhp   = Color(1,0.16,0.41,1)     #ff2869
export(Color) var lowdef  = Color(0.18,0.14,1,1)     #2f23ff
export(Color) var normhp  = Color(0.57,0.95,0.04,1)  #92f40b
export(Color) var normdef = Color(0.43,0.74,0.93,1)  #6dbded
export(Color) var med     = Color(0.96,0.72,0.29,1)  #f5b949

#const lowhp   = Color(1,0.16,0.41,1)     #ff2869
#const lowdef  = Color(0.18,0.14,1,1)     #2f23ff
#const normhp  = Color(0.57,0.95,0.04,1)  #92f40b
#const normdef = Color(0.43,0.74,0.93,1)  #6dbded
#const med     = Color(0.96,0.72,0.29,1)  #f5b949

func _ready():
  FileMan.connect("upd_cur_stats", self, "update_stats_shown")
  
func update_stats_shown():
  hp.value = FileMan.data.get(get_who().to_lower())["HP"]
  def.value = FileMan.data.get(get_who().to_lower())["DEF"]
  mana.value = FileMan.data.get(get_who().to_lower())["MANA"]
  pass

func get_who():
  if who == 0:
    return "Kevin"
  if who == 1:
    return "Quinton"
  if who == 2:
    return "Charlie"
  if who == 3:
    return "Bella"
  pass

func set_who(value):
  $"hp-cont".frame=value
  $Character.frame=value

func _process(_delta):
  #if lowhp
  if (hp.value<=hp.max_value/2 && hp.value>hp.max_value/3):
    hp.tint_progress=med
  elif hp.value<=(hp.max_value/3):
    hp.tint_progress=lowhp
  else:
    hp.tint_progress=normhp

  if (def.value<=def.max_value/2 && def.value>def.max_value/3):
    def.tint_progress=med
  elif def.value<=(def.max_value/3):
    def.tint_progress=lowdef
  else:
    def.tint_progress=normdef

  hplabel.text=str(hp.value)
  hpmax.text=str(hp.max_value)
  deflabel.text=str(def.value)
  defmax.text=str(def.max_value)
  manalabel.text=str(mana.value)
  manamax.text=str(mana.max_value)
  pass
