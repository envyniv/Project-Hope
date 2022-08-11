#made to avoid Cyclic referencing

#I HATE CYCLIC REFERENCES


extends Resource
class_name MapDefinition

# export(PackedScene) var map
export(String) var localizedName
export(AudioStream) var bgm
export(String) var bgmName
export(float) var windStrength
export(Color) var vegetation
