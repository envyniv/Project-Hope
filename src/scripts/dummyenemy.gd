extends KinematicBody2D

var stats = {
	HP = 20,
	maxHP = 20, #1 to 999
	DEF = 10,
	maxDEF = 10, #1 to 499
	MANA = 5,
	maxMANA = 5, #1 to 10
	EVA = 5, #1 to 4; 1 = 10% chance avoid
	LV = 1, #1 to 99
	PRO = 1, #1 to 3x times the XP
	CHR = 0, #0 to 30% chance of inflicting lovestun
	LUC = 0, #0 to 40% chance of crit
	ATK = 3, #1 to 250?
}

func can_interact(interactParent : Node) -> bool:
	return interactParent is Player

func _interact(_interactParent : Node) -> void:
	#SaveLoad.switch_stage={true:"battle"}
	#SaveLoad.inBattle={true:"dummy"}
  SceneManager.change_scene("game",0)
