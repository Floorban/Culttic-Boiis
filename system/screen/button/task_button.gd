class_name TaskButton
extends Button


signal start_task_request(task : Task)


@export var task : Task


func _ready() -> void:
	toggled.connect(_on_task_btn_toggled)


func _on_task_btn_toggled(toggled_on : bool) -> void:
	if toggled_on:
		start_task_request.emit(task)


func disable_button(disable : bool) -> void:
	disabled = disable
	if not disabled:
		button_pressed = disabled
