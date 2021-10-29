extends Node

var save_class=load("res://scripts/SaveFile.gd")
var sets_class=load("res://scripts/SettingsFile.gd")
var path1="res://save.tres"
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
var curtime

#         "controls":
#                 "ui_left":"A"
#                 "ui_right":"D"
#                 "ui_up":"W"
#                 "ui_down":"S"
#                 "sprint":"Shift"
#                 "ui_accept":"A"
#                 "atkmed":"S"
#                 "ui_cancel":"X"
#                 "ui_select":"Z"

func _load_paks() ->void:
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
  #for i in data.mods:
  #  print(ProjectSettings.load_resource_pack("res://mods/%s" % i))
  else:
    print("no mods found.")
  return

func _init() ->void:
  _load_paks()
  load_settings()
  return

func load_game() ->void:
  data = load(slotselected)
  return

func load_settings() ->void:
  if ResourceLoader.exists(setpath):
    settings = load(setpath)
    #data.preview=settings.preview
    TranslationServer.set_locale(settings.lang)
  return

func save_game() ->void:
  #warning-ignore:return_value_discarded
  ResourceSaver.save(slotselected, data)
  return

func dump2sets() ->void:
  #warning-ignore:return_value_discarded
  ResourceSaver.save(setpath, settings)
  #OS.alert("", "Save error ()")
  return

func reset_data() ->void:
  data=save_class.new()

func delete_save():
  var dir = Directory.new()
  dir.remove(slotselected)
  return

func save_check(which=4):
  match which:
    1:
      if ResourceLoader.exists(path1):
        return true
    2:
      if ResourceLoader.exists(path2):
        return true
    3:
      if ResourceLoader.exists(path3):
        return true
    _:
      if ResourceLoader.exists(path1):
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
  return

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
  var details : Dictionary = {}
  for i in 2: #0, 1, 2
    if save_check((i+1)):
      slotselected=get("path%s" % (i+1))
      load_game()
      details["%s" % (i+1)]={ "name":data.name, "location":data.location,"playtime":data.playtime,"preview":data.preview.data["data"] }
  return details
