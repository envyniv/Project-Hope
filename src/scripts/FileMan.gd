extends Node

var save_class=load("res://scripts/SaveFile.gd")
var path="res://save.tres"
var langfile   = "res://scripts/diag/lang.json"

var money=100 #max 999.999
var level=1 #max 99
var switch_stage={false:null}
signal upd_cur_stats

var data = save_class.new()

# var default_data = {
#     "settings": {
#         "controls":
#             {
#                 "ui_left":"A",
#                 "ui_right":"D",
#                 "ui_up":"W",
#                 "ui_down":"S",
#                 "sprint":"Shift",
#                 "ui_accept":"A",
#                 "atkmed":"S",
#                 "ui_cancel":"X",
#                 "ui_select":"Z",
#             },
#     },
# }

func _load_paks():
  #load base game
  var executableName = str(OS.get_executable_path().get_basename().get_file())
  var f=File.new()
  if f.file_exists("res://%s.zip" % executableName):
  # warning-ignore:return_value_discarded
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
      data.mods.append(file)
      file=folder.get_next()
      print(data.mods)
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
  load_settings()

func load_game():
  #if file_check(path):
  #var gameload = load(path)
  #data=gameload.duplicate()
  data = load(path)
  #var file=File.new();
  #file.open_encrypted_with_pass(path, File.READ, "xd.png")
  #var text=file.get_as_text()
  #data=parse_json(text)
  #file.close()

func load_settings():
  var settings = load(path)
  data.lang = settings.lang
  data.voice = settings.voice
  data.bgmvol = settings.bgmvol
  data.sfxvol = settings.sfxvol

func save_game():
  #warning-ignore:return_value_discarded
  ResourceSaver.save(path, data)

func reset_data():
  data=save_class.new()

func save_check():
  if ResourceLoader.exists(path):
    return true
  else:
    return false

func return_file_as_text(file):
  var f=File.new()
  if f.file_exists(file):
    f.open(file, File.READ)
    var ret=f.get_as_text()
    f.close()
    return ret
  else:
    return false

func add_item(item):
  if data.inv.size()==255:
    return false
  else:
    data.inv.append(item)

func remove_item(item):
  data.inv.erase(item)

func add_party():
  pass

func remove_party():
  pass

func update_values(whose):
  var who = whose.name.to_lower()
  data.get(who)["HP"]=whose.HP
  data.get(who)["DEF"]=whose.DEF
  data.get(who)["MANA"]=whose.MANA
  emit_signal("upd_cur_stats")

func returnTranslation(string):
  var langdata = return_file_as_text(FileMan.langfile)
  var json = JSON.parse(langdata).result
  for i in json:
    if json[i]["dir"] == data.lang:
      return json[i][string]

