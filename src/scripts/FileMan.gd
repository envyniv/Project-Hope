extends Node

var save_class=load("res://scripts/SaveFile.gd")
var path="res://save.tres"

var party=[] #max 3
var inv=[]
var mods=[]

var money=100 #max 999.999
var level=1 #max 99
var inDialog=false
var switch_stage={false:null}

var data = save_class.new()

# var default_data = {
#     "player":{
#         "level":1,
#         "money":100,
#         "party":[],
#         "inv":[], #inventory, duh
#         "Kevin":{ #stats show base, not bonuses
#             "LVL":1,
#             "HP":20, #health
#             "DEF":10, #defense
#             "EVA":8, #evasion
#             "ATK":12, #attack
#             "LV":1, #level
#             "EXP":0, #experience
#             "PRO":0, #proficiency/times the exp 0x up to 3x
#             "CHR":0, #charm
#             "LUC":0, #luck/chance of crit hit
#             "god":[],
#             "equip":[],
#         },
#         "Quinton":{
#             "LVL":1,
#             "HP":17,
#             "DEF":25,
#             "EVA":6,
#             "ATK":8,
#             "LV":1,
#             "EXP":0,
#             "PRO":0,
#             "CHR":0,
#             "LUC":0,
#             "equip":[],
#         },
#         "Charlie":{
#             "LVL":1,
#             "HP":17,
#             "DEF":25,
#             "EVA":6,
#             "ATK":8,
#             "LV":1,
#             "EXP":0,
#             "PRO":0,
#             "CHR":0,
#             "LUC":0,
#             "equip":[],
#         },
#         "Bella":{
#             "LVL":1,
#             "HP":17,
#             "DEF":25,
#             "EVA":6,
#             "ATK":8,
#             "LV":1,
#             "EXP":0,
#             "PRO":0,
#             "CHR":0,
#             "LUC":0,
#             "equip":[],
#         },
#     },
#     "location": {
#         "map":"kevinsbedroom",
#     },
#     "settings": {
#         "bgmvol":1,
#         "sfxvol":1,
#         "voice":0,
#         "lang":"en",
#         "controls":
#             {
#                 "ui_left":"A",
#                 "ui_right":"D",
#                 "ui_up":"W",
#                 "ui_down":"S",
#                 "sprint":"Shift",
#                 "ui_accept":"J",
#                 "atkmed":"K",
#                 "ui_cancel":"N",
#                 "ui_select":"M",
#             },
#     },
# }

var tempdata = {}

func _load_paks():
  #load base game
  var executableName = str(OS.get_executable_path().get_basename().get_file())
  var f=File.new()
  if f.file_exists("res://%s.zip" % executableName):
    ProjectSettings.load_resource_pack("res://%s.zip" % executableName)
  else:
    OS.alert("Make sure there's a copy of 'Project-Hope.zip' in the game folder\nand that the executable and it share the same filename", "Missing Game Data!")

#load mods, don't need to check if valid or not, godot won't load if not valid
  var folder = Directory.new()
  if folder.open("mods") == OK:
    print("mods available")
    folder.list_dir_begin()
    var file=folder.get_next()
    while file!="":
      mods.append(file)
      file=folder.get_next()
    print(mods)
    # FIXME: somehow loaded files are used by ShopUI?
    #for i in mods:
    #  print(ProjectSettings.load_resource_pack("res://mods/%s" % i))
  else:
    print("no mods found.")

func _init():
  #if !save_check("settings"):
  #    data["settings"]=default_data["settings"].duplicate(true)
  #else:
  #    var file=File.new();
  #    file.open_encrypted_with_pass(path, File.READ, "xd.png")
  #    var text=file.get_as_text()
  #    data["settings"]=parse_json(text)["settings"]
  #    file.close()
  _load_paks()

func load_game():
  if file_check(path):
    var gameload = load(path)
  #var file=File.new();
  #file.open_encrypted_with_pass(path, File.READ, "xd.png")
  #var text=file.get_as_text()
  #data=parse_json(text)
  #file.close()

func save_game():
  ResourceSaver.save(path, data)

func reset_data():
  #data=default_data.duplicate(true)
  pass

# TODO: reimplement this with resources in mind
# HACK: IF YOU WANT TO CHECK FOR SETTINGS, DO save_check("settings")
func save_check(check="player"):
  #var file=File.new();
  #file.open_encrypted_with_pass(path, File.READ, "xd.png")
  #if file.file_exists(path):
  #    print("savefile at %s found." % path)
  #    var text=file.get_as_text()
  #    if parse_json(text).has(check):
  #        print("%s found in %s" % [check, path])
  #        return true
  #    else:
  #        print("%s NOT found in %s" % [check, path])
  #        return false
  #else:
  #    print("%s not found." % path)
  #file.close()
  pass

func file_check(file):
  var f=File.new()
  var chk = f.file_exists(file)
  return chk

func return_file(file):
  if file_check(file):
    var f=File.new()
    var ret=f.open(file, File.READ)
    f.close()
    return print(ret)
  else:
    return false

func add_item(item):
    if inv.size()==255:
        return false
    else:
        inv.append(item)

func remove_item(item):
    inv.erase(item)
