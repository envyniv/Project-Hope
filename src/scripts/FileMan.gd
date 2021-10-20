extends Node

var save_class=load("res://scripts/SaveFile.gd")
var sets_class=load("res://scripts/SettingsFile.gd")
var path="res://save.tres"
var path2="res://save2.tres"
var path3="res://save3.tres"
var setpath="res://settings.tres"

var money=100 #max 999.999
var level=1 #max 99
var switch_stage={false:null}
signal upd_cur_stats
var slotselected

var settings = sets_class.new()
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
  elif !OS.has_feature("editor"):
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
  _load_paks()
  load_settings()

func load_game():
  data = load(slotselected)

func load_settings():
  if ResourceLoader.exists(setpath):
    settings = load(setpath)
    data.preview=settings.preview
    data.lang = settings.lang
    data.voice = settings.voice
    data.bgmvol = settings.bgmvol
    data.sfxvol = settings.sfxvol
    TranslationServer.set_locale(settings.lang)

func save_game():
  #warning-ignore:return_value_discarded
  ResourceSaver.save(slotselected, data)

func dump2sets():
  ResourceSaver.save(setpath, settings)

func reset_data():
  data=save_class.new()

func save_check():
  if ResourceLoader.exists(path):
    return true
  elif ResourceLoader.exists(path2):
    return true
  elif ResourceLoader.exists(path3):
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

func return_saves_details():
  var details : Dictionary
  return details
