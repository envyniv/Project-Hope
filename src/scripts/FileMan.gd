extends Node
var saves      = []
var mods       = []
var setpath    = "res://settings.tres"
var modpath    = "res://mods"
var savespath  = "res://saves"

var sfxbus = AudioServer.get_bus_index("sfx")
var mtrbus = AudioServer.get_bus_index("Master")
var bgmbus = AudioServer.get_bus_index("bgm")

signal party_updated

var settings = SettingsFile.new()
var data = Save.new()
var curtime = 0

func _init() -> void:
  load_settings()
  probe_saves()
  probe_mods()
  curtime = OS.get_unix_time()
  randomize()
  return

func load_zip() -> void:
  var executableName = str(OS.get_executable_path().get_basename().get_file())
  var f = File.new()
  if f.file_exists("res://%s.zip" % executableName):
  # warning-ignore:return_value_discarded
    ProjectSettings.load_resource_pack("res://%s.zip" % executableName)
  elif !OS.has_feature("editor"):
    OS.alert(TranslationServer.translate("errDataMissingStr") % executableName, TranslationServer.translate("errDataMissing"))
  return

func load_game(slotselected) -> void:
  data = slotselected
  load_mods()
  return

func load_mods():
  for i in data.mods:
    for j in i.resourcePacks:
      ProjectSettings.load_resource_pack(j)
  return

func load_settings() -> void:
  if ResourceLoader.exists(setpath):
    settings = load(setpath)
    TranslationServer.set_locale(settings.lang)
    AudioServer.set_bus_volume_db(bgmbus, linear2db(settings.bgmvol))
    AudioServer.set_bus_volume_db(sfxbus, linear2db(settings.sfxvol))
    AudioServer.set_bus_volume_db(mtrbus, linear2db(settings.mtrvol))
  return

func save_game() -> void:
  #warning-ignore:return_value_discarded
  ResourceSaver.save(FileMan.data.resource_path, data)
  return

func dump2sets() -> void:
  #warning-ignore:return_value_discarded
  ResourceSaver.save(setpath, settings)
  #OS.alert("", "Save error ()")
  return

func reset_data() -> void:
  data = Save.new()
  return

func delete_save(savefile) -> void:
  var dir = Directory.new()
  dir.remove(savefile.resource_path)
  return

func copy_save() -> void:
  data.resource_path = str(
                             "res://saves/",
                             data.name,
                             OS.get_unix_time(),
                             ".tres"
                            )
  save_game()
  reset_data()
  return

func probe_mods() -> void:
  var dir = Directory.new()
  if dir.open(modpath) == OK:
    print("Mods folder present")
    dir.list_dir_begin()
    var file = dir.get_next()
    while file != "":
      if !file.begins_with("."):
        if dir.current_is_dir():
          dir.change_dir(file)
        elif file.ends_with(".tres"):
          print(file)
          var mod = load(str(modpath,"/",file))
          mods.append(mod)
          for i in mod.translations:
            TranslationServer.add_translation(i)
          mod = null
      file = dir.get_next()
    dir.list_dir_end()
  else:
    print("Mods folder not present")
  return

func probe_saves() -> void:
  var dir = Directory.new()
  if !dir.dir_exists(savespath):
    dir.make_dir(savespath)
  dir.open(savespath)
  dir.list_dir_begin()
  var file = dir.get_next()
  while file != "":
    if (!file.begins_with(".") && file.ends_with(".sav")):
      var sav = load((str(savespath,"/",file)))
      saves.append(sav)
      sav = null
    file = dir.get_next()
  dir.list_dir_end()
  return

func add_item(item) -> bool:
  if !(item in data.inv):
    data.inv[item] = 1
  else:
    if data.inv[item] >= 20:
      data.inv[item] = 20
      return false
    else:
      data.inv[item] += 1
  return true

func remove_item(item) -> void:
  if data.inv[item] <= 1:
    data.inv.erase(item)
  else:
    data.inv[item] -= 1
  return

func add_party(lifeform : Resource) -> int:
  if (lifeform is Lifeform):
    if data.partyRes.size() < 3:
      print("Fileman.gd:add_party(); adding to party.")
      data.partyRes.append(lifeform)
      emit_signal("party_updated")
    else:
      print("Fileman.gd:add_party(); can't add to party.")
      return 1
  return 0

func remove_party(lifeform: Resource) -> int:
  if (lifeform is Lifeform):
    if lifeform in data.partyRes:
      data.partyRes.erase(lifeform)
      print("Fileman.gd:remove_party(); removed from party.")
    else:
      print("Fileman.gd:remove_party(); can't remove from party.")
      return 1
  else:
    return 1
  return 0

func replace_binds() -> void:
  # note to self: deleting ACTIONS and readding them does not seem to work.
  # however, deleting EVENTS and readding them is fine.
  for i in InputMap.get_actions():
    if i in settings.controls["keyboard"]:
      if i != "ui_end":
        InputMap.action_erase_events(i)
      var key=InputEventKey.new()
      key.scancode = settings.controls["keyboard"][i]
      InputMap.action_add_event(i, key)

# commented because i didn't feel like completing it, and plus it's like hell to work with.
    """
    if i in settings.controls["controller"]:
      var key  = InputEventJoypadButton.new()
      if i!=("ui_up"||"ui_down"||"ui_left"||"ui_right"):
        key.scancode=settings.controls["controller"][i]
      else:
        var axis = InputEventJoypadMotion.new()
        axis.axis    = settings.controls["controller"][i][0] #first element, axis
# should also set the value of the axis here (axis_value)
        key.scancode = settings.controls["controller"][i][1] #second element, dpad
      InputMap.action_add_event(i, key)
    """
  return
