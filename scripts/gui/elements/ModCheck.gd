extends CheckBox
class_name ModCheckBox

export(Resource) var pointing : Resource setget setup

func setup(pointTo) -> void:
  name = pointTo.name
  text = TranslationServer.translate(pointTo.name)
  pointing = pointTo
  return
