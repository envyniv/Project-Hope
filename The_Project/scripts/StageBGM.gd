extends Node
onready var player=$AudioStreamPlayer
var battle1 = preload("res://assets/OST/BGM/bits.ogg") #Battle To Bits
var battle2 = preload("res://assets/OST/BGM/crazy.ogg") #About To Get Crazy
var battle3 = preload("res://assets/OST/BGM/enemy.ogg") #From The Enemy
var battle4 = preload("res://assets/OST/BGM/hand.ogg") #What Has It Come To?
var battle5 = preload("res://assets/OST/BGM/orchestra.ogg") #Orchestrating A Fight
var battle6 = preload("res://assets/OST/BGM/sounds.ogg") #Sounds Of Battle
var thoughtful = preload("res://assets/OST/BGM/thoughtful.ogg") #Orchestrating A Fight - non battle
var save = preload("res://assets/OST/BGM/save.ogg") #Time To Save
var winter = preload("res://assets/OST/BGM/winter.ogg") #New World
var sweet = preload("res://assets/OST/BGM/sweet.ogg") #Sweet Melody
var start = preload("res://assets/OST/BGM/start.ogg") #Start of a Story
var night = preload("res://assets/OST/BGM/night.ogg") #Prima Luna
func _ready():
	player.stream = battle1
	#player.play()
	pass
