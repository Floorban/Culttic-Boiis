extends TextureButton
class_name SkillNode

@onready var skill_level: Label = $SkillLevel
@onready var skill_branch: Line2D = $SkillBranch

@export var skill: SkillData
var level := 0:
	set(value):
		level = clampi(value, 0, skill.max_level)
		skill_level.text = str(level) + "/" + str(skill.max_level)

func _ready() -> void:
	if get_parent() is SkillNode:
		hide()
	_init_line()
	pressed.connect(_on_pressed)
	
func _init_line() -> void:
	var p := get_parent()
	if p is not SkillNode:
		return
		
	skill_branch.clear_points()
	await get_tree().process_frame
	
	var my_center = global_position + size / 2
	skill_branch.add_point(skill_branch.to_local(my_center))
	
	var parent_global_center = p.global_position + (p.size / 2)
	var parent_local_pos = skill_branch.to_local(parent_global_center)
	skill_branch.add_point(parent_local_pos)
	
	#skill_branch.add_point(global_position + size / 2)
	#skill_branch.add_point(p.global_position + p.size / 2)

func _on_pressed() -> void:
	if level == skill.max_level or not GameManager.can_consume_points(skill.needed_points):
		return
	self_modulate = Color.LIGHT_GREEN
	skill_branch.default_color = Color.GREEN
	level = min(level + 1, skill.max_level)
	GameManager.consume_points(skill.needed_points)
	GameManager.upgrades.unlock(skill)
	_unlock_next_skills()

func _unlock_next_skills() -> void:
	var skills = get_children()
	for s in skills:
		if s is SkillNode and level == skill.max_level:
			s.disabled = false
			s.show()
