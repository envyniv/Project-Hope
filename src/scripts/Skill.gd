extends Resource
class_name Skill
export(String) var name
export(String, MULTILINE) var Description
export(int,0,10) var RequiredMana
enum use {
  AIM,
  SELECT_TEAM
  SELECT_ENEMY
  SELECT
  SELF
 }
export(use) var usage
export(String, "HEALING","BUFF","DEBUFF","ATTACK","STATUS","MIX") var type
