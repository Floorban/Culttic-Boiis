class_name StatsManager
extends Control


func _ready() -> void:
	GameManager.stats_manager = self


func get_stats(task: Task) -> void:
	print(task.task_description)
