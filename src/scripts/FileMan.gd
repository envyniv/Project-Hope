extends Node

var save_class=load("res://scripts/SaveFile.gd")
var sets_class=load("res://scripts/SettingsFile.gd")
var path1="res://save.tres"
var path2="res://save2.tres"
var path3="res://save3.tres"
var setpath="res://settings.tres"

#var money=100 #max 999.999
#var level=1 #max 99
#var switch_stage={false:null}
signal upd_cur_stats
var slotselected

var settings = sets_class.new()
var data = save_class.new()
var curtime = 0

func _load_paks() -> void:
  #load base game
  var executableName = str(OS.get_executable_path().get_basename().get_file())
  var f=File.new()
  if f.file_exists("res://%s.zip" % executableName):
  # warning-ignore:return_value_discarded
    ProjectSettings.load_resource_pack("res://%s.zip" % executableName)
  elif !OS.has_feature("editor"):
    OS.alert(TranslationServer.translate("errDataMissingStr") % executableName, TranslationServer.translate("errDataMissing"))

#load mods, don't need to check if valid or not, godot won't load if not valid
  var folder = Directory.new()
  if folder.open("mods") == OK:
    print("mods available")
    folder.list_dir_begin()
    var file=folder.get_next()
    while file!="":
      if file!="." && file!="..":
        data.mods.append(file)
      file=folder.get_next()
  # FIXME: somehow loaded files are used by ShopUI?
  else:
    print("no mods found.")
#  for i in data.mods:
#    print(ProjectSettings.load_resource_pack("res://mods/%s" % i))
  return

func _init() -> void:
  _load_paks()
  load_settings()
  return

func load_game() -> void:
  data = load(slotselected)
  return

func load_settings() -> void:
  if ResourceLoader.exists(setpath):
    settings = load(setpath)
    #data.preview=settings.preview
    TranslationServer.set_locale(settings.lang)
  return

func save_game() -> void:
  #warning-ignore:return_value_discarded
  ResourceSaver.save(slotselected, data)
  return

func dump2sets() -> void:
  #warning-ignore:return_value_discarded
  ResourceSaver.save(setpath, settings)
  #OS.alert("", "Save error ()")
  return

func reset_data() -> void:
  data=save_class.new()
  return

func delete_save() -> void:
  var dir = Directory.new()
  dir.remove(slotselected)
  return

func save_check(which=4): #wouldbe bool
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

func return_file_as_text(file): #Variant
  var f=File.new()
  if f.file_exists(file):
    f.open(file, File.READ)
    var ret=f.get_as_text()
    f.close()
    return ret
  else:
    return false

func add_item(item) -> bool:
  if !(item in data.inv):
    data.inv[item]=1
  else:
    if data.inv[item]>=20:
      data.inv[item] = 20
      return false
    else:
      data.inv[item]+=1
  return true

func remove_item(item) -> void:
  if data.inv[item]<=1:
    data.inv.erase(item)
  else:
    data.inv[item]-=1
  return

func add_party(): #TODO
  pass

func remove_party(): #TODO
  pass

func update_values(whose) -> void:
  var who = whose.name.to_lower()
  data.get(who)["HP"]=whose.HP
  data.get(who)["DEF"]=whose.DEF
  data.get(who)["MANA"]=whose.MANA
  emit_signal("upd_cur_stats")
  return

func return_saves_details() -> Dictionary:
  var details : Dictionary = {}
  for i in 2: #0, 1, 2
    if save_check((i+1)): #1, 2, 3
      slotselected=get("path%s" % (i+1))
      load_game()
      details["%s" % (i+1)]={ "name":data.name, "location":data.location,"playtime":data.playtime,"preview":data.preview.data["data"] }
  return details

func replace_binds() -> void:
  #note to self: deleting actions and readding them does not seem to work.
  #however, deleting events and readding them programmatically is fine.
  for i in InputMap.get_actions():
    if i in settings.controls["keyboard"]:
      if i != "ui_end":
        InputMap.action_erase_events(i)
      var key=InputEventKey.new()
      key.scancode = settings.controls["keyboard"][i]
      InputMap.action_add_event(i, key)
    
# commented because who tf gon rebind controller keys????? also not complete
#      
#    if i in settings.controls["controller"]:
#      var key  = InputEventJoypadButton.new()
#      if i!=("ui_up"||"ui_down"||"ui_left"||"ui_right"):
#        key.scancode=settings.controls["controller"][i]
#      else:
#        var axis = InputEventJoypadMotion.new()
#        axis.axis    = settings.controls["controller"][i][0] #first element, axis
# should also set the value of the axis here (axis_value)
#        key.scancode = settings.controls["controller"][i][1] #second element, dpad
#      InputMap.action_add_event(i, key)
  return
