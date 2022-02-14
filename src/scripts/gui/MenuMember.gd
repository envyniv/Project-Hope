extends NinePatchRect

export(String, "kevin", "quinton", "charlie", "bella") var who

onready var character = $VBoxContainer/TextureRect
onready var level = $VBoxContainer/TextureRect/Level
onready var hpbar = $VBoxContainer/TextureRect/HPBar
onready var defbar = $VBoxContainer/TextureRect/DEFBar
onready var nameLabel = $VBoxContainer/TextureRect/Name
onready var xpLabel = $VBoxContainer/TextureRect/XP

onready var Helm = $VBoxContainer/HBoxContainer/Equip/Buttons/Helm
onready var Armor = $VBoxContainer/HBoxContainer/Equip/Buttons/Armor
onready var Charm = $VBoxContainer/HBoxContainer/Equip/Buttons/Charm

onready var xMANA=$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/xMANA
onready var EVA=$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/EVA
onready var DEF=$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/DEF
onready var ATK=$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/ATK
onready var LUC=$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/LUC

signal exit_menumember
signal iRequireItems

func _ready() -> void:
  setup()
  Helm.connect("pressed", self, "helmPressed")
  Armor.connect("pressed", self, "armorPressed")
  Charm.connect("pressed", self, "charmPressed")
  return

func setup() -> void:
  hpbar.setup()
  defbar.setup()
  return

func _process(_delta) -> void:
  #i can probably do this some other way that i don't know of yet
  if who:
    var whodata = FileMan.data.get(who)
    
    hpbar.update_value(whodata["HP"])
    hpbar.max_value=whodata["maxHP"]
    defbar.update_value(whodata["DEF"])
    defbar.max_value=whodata["maxDEF"]
    xpLabel.text = TranslationServer.translate("statEXP")+": "+str(whodata["EXP"])+" / "+str(whodata["nextEXP"])

    level.text = str(whodata["LVL"])

    xMANA.text = str(whodata["maxMANA"])
    DEF.text   = str(whodata["DEF"])
    ATK.text   = str(whodata["ATK"])
    LUC.text   = str(whodata["LUC"])
    EVA.text   = str(whodata["EVA"])
  return

func _input(_event : InputEvent) -> void:
  if Input.is_action_pressed("ui_cancel"):
    emit_signal("exit_menumember")
    release_focus()
  return

func itemReceived(type : String, itemfile : String) -> void:
  disconnect("itemSelected", self, "itemReceived")
  match type:
    "HELM":
      Helm.text = TranslationServer.translate(itemfile)
    "ACCESSORY":
      Charm.text = TranslationServer.translate(itemfile)
    "EQUIP":
      Armor.text = TranslationServer.translate(itemfile)
  FileMan.data.get(who)["equip"][type] = itemfile
  return

func helmPressed() -> void:
  emit_signal("iRequireItems", "HELM")
  return

func armorPressed() -> void:
  emit_signal("iRequireItems", "EQUIP")
  return
  
func charmPressed() -> void:
  emit_signal("iRequireItems", "ACCESSORY")
  return
