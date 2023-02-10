# tool

extends Resource
class_name GameMod
#export(Texture) var icon
export(String) var name
export(String) var description
export(String) var ver
export(Vector3) var intendedFor                 # NOTE: what LH version this is intended for.
var lastChange: int                             # NOTE: unix timestamp
export(String) var Author
export(String) var ReportPage                   # NOTE: link to a page where to report issues, GitHub/GitLab issue pages are preferred.
export(String) var scRepo                       # NOTE: link to source code, GitHub/GitLab are preferred.

export(Dictionary) var exposedSettings          # NOTE: this will determine what settings are exposed in the Save selection menu.
                                                #       the key has to be a string, while the value can be of any type.
                                                #       If the key is not a string, it will not show up
                                                #       Valid Setting values are String, bool, int, float, Vector3, Vector2, Color

                                                #       Sliders (int/float):
                                                #         "myIntSlider": {
                                                #           "def": 50,
                                                #           "max": 100,
                                                #           "min": 0
                                                #         },
                                                #         "myFloatSlider": {
                                                #           "def": 49.2,
                                                #           "max": 55.75,
                                                #           "min": -1.23
                                                #         }

                                                #       RollBox (Int/Float):
                                                #         "myIntRollBox": 53

export(Array, Translation) var translations     # generate translations however you want, then include them here.

export(Array, String, FILE, "*.zip") var resourcePacks
