class_name TaskManager
extends Node

@export var task_btns: Array[TaskButton]
@export var task_slots : Array[TaskProgress]

var max_parallel_tasks := 2


func _ready() -> void:
	for b in task_btns:
		b.toggled.connect(_disable_all_buttons)
		b.start_task_request.connect(start_task)
	
	for s in task_slots:
		s.task_finished.connect(_on_task_finished)


func start_task(task : Task) -> bool:
	var running := 0
	for slot in task_slots:
		if slot.is_running:
			running += 1

	if running >= max_parallel_tasks:
		return false
		
	for slot in task_slots:
		if not slot.is_running:
			slot.start_task(task)
			return true

	return false


func _on_task_finished(task : Task) -> void:
	_disable_all_buttons(false)
	print(task.task_name)


func _disable_all_buttons(disable: bool) -> void:
	for b in task_btns:
		b.disabled = disable
		if not b.disabled:
			b.button_pressed = disable
