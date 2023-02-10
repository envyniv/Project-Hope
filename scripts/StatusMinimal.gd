extends Control
onready var hp=$Who/HP
onready var hp1=$Party1/HP
onready var hp2=$Party2/HP
onready var hp3=$Party3/HP
onready var hplabel=$Who/HP/RichTextLabel
onready var def=$Who/DEF
onready var def1=$Party1/DEF
onready var def2=$Party2/DEF
onready var def3=$Party3/DEF

var lowhp=Color(1,0.16,0.41,1)#ff2869
var lowdef=Color(0.18,0.14,1,1)#2f23ff
var normhp=Color(0.57,0.95,0.04,1)#92f40b
var normdef=Color(0.43,0.74,0.93,1)#6dbded
var med=Color(0.96,0.72,0.29,1)#f5b949


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
	
	hplabel.bbcode_text="[right][b]%s[i]/[/i][/b]%s[/right]" % [hp.value, hp.max_value]
