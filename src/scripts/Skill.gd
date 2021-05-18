extends Resource
class_name Skill
export(String) var name
export(String, MULTILINE) var Description
export(int,0,999999) var RequiredMana
export(String, "HEALING","BUFF","DEBUFF","ATTACK","STATUS","MIX") var type
