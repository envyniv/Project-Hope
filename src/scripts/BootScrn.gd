extends Node

func _ready():
	var executableName = str(OS.get_executable_path().get_basename().get_file())
	var f=File.new()
	var fCheck = f.file_exists("res://%s.zip" % executableName)
	if fCheck:
	   ProjectSettings.load_resource_pack("res://%s.zip" % executableName)

	SceneManager.change_scene("title",0)
