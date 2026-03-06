class_name TaskButton
extends Button

signal start_task_request(task: Task, button: TaskButton)

@export var task : Task


func _ready() -> void:
	toggled.connect(_on_task_btn_toggled)


func _on_task_btn_toggled(toggled_on : bool) -> void:
	if toggled_on:
		start_task_request.emit(task, self)


var fail_tween : Tween

func button_press_failed() -> void:
	button_pressed = false
	var og_color = Color.WHITE
	modulate = og_color
	
	if fail_tween:
		fail_tween.kill()
	fail_tween = create_tween()
	fail_tween.tween_property(self, "modulate", Color(0.796, 0.0, 0.0, 1.0), 0.08)
	fail_tween.tween_property(self, "modulate", og_color, 0.1)
	fail_tween.tween_callback(func(): modulate = og_color)


func disable_button(disable : bool) -> void:
	disabled = disable
	if not disabled:
		button_pressed = disabled
