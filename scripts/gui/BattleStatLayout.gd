extends HBoxContainer

export(PackedScene) var hpConScene

func _ready() -> void:
  var err = update_party()
  if err:
    print("BattleStatLayout.gd: update(); something went REALLY wrong here.")
  return

func update_party() -> int:
  #party lead
  var p = hpConScene.instance()
  add_child(p)
  p.pointing = FileMan.data.lead
  p.setup()
  #TODO: validate code
  for Lifeform in FileMan.data.partyRes:
    var f = hpConScene.instance()
    add_child(f)
    f.pointing = Lifeform
    f.setup()
  return 0
