extends Resource
class_name Settings
#sys
export(Array) var mods

#settings
export(float) var sfxvol = 1.000
export(float) var bgmvol = 1.000
export(float) var txtspd = 0.05
export(bool) var voice = true
export(int, 1, 3) var scale = 1
export(String) var lang = "en"
export(Dictionary) var controls = {
  "keyboard":{
  "ui_accept":     KEY_Z,    # skill button
  "ui_select":     KEY_S,    # item button
  "ui_cancel":     KEY_X,    # also attack button
  "defend":        KEY_A,    # defend
  "ui_up":         KEY_UP,
  "ui_down":       KEY_DOWN,
  "ui_left":       KEY_LEFT,
  "ui_right":      KEY_RIGHT,
  "ui_focus_next": KEY_SPACE,
  "sprint":        KEY_SHIFT
  }
}
# commented because FileMan.gd:165
#  "controller":{
#    #T/O/D/O: this.
#    "ui_accept":2,     #SONY SQUARE  , XBOX X , NINTENDO Y
#    "ui_select":1,     #SONY CIRCLE  , XBOX B , NINTENDO A
#    "ui_cancel":0,     #SONY X       , XBOX A , NINTENDO B
#    "defend":   3,     #SONY TRIANGLE, XBOX Y , NINTENDO X
#    # controllers are so fucking retarded holy fucking shit
#    "ui_up":    [JOY_AXIS_1, JOY_DPAD_UP],
#    "ui_down":  [JOY_AXIS_1, JOY_DPAD_DOWN],
#    "ui_left":  [JOY_AXIS_0, JOY_DPAD_LEFT],
#    "ui_right": [JOY_AXIS_0, JOY_DPAD_RIGHT],
#    "ui_focus_next":JOY_R,
#    "sprint":JOY_R2
#   }
