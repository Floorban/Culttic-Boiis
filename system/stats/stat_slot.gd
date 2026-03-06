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
	update_ui()


func _on_stat_changed(changed_stat: Stat, value: int) -> void:
	if changed_stat == stat:
		stat_num_label.text = str(value)


func update_ui():
	stat_num_label.text = str(stats_manager.get_stat(stat))
