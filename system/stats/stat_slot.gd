class_name StatSlot
extends Control

@onready var stats_manager = get_parent() as StatsManager

@export var stat : Stat
@onready var stat_icon: TextureRect = $StatIcon
@onready var stat_num_label: Label = $StatNumLabel


func _ready() -> void:
	if stat:
		stat_icon.texture = stat.stat_icon
	if stats_manager:
		stats_manager.stat_changed.connect(_on_stat_changed)
		stats_manager.stat_cost_failed.connect(_pay_with_stat_failed)


func _on_stat_changed(changed_stat: Stat, value: int) -> void:
	if changed_stat == stat:
		stat_num_label.text = str(value)


var fail_tween : Tween

func _pay_with_stat_failed(changed_stat: Stat) -> void:
	if changed_stat != stat:
		return
	var og_color = Color.WHITE
	stat_num_label.modulate = og_color
	
	if fail_tween:
		fail_tween.kill()
	fail_tween = create_tween()
	fail_tween.tween_property(stat_num_label, "modulate", Color(0.796, 0.0, 0.0, 1.0), 0.1)
	fail_tween.tween_property(stat_num_label, "modulate", og_color, 0.15)
	fail_tween.tween_callback(func(): stat_num_label.modulate = og_color)
