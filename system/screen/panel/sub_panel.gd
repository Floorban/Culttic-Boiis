class_name SubPanel extends Control

signal focus_panel(panel: SubPanel)


func hide_panel() -> void:
	hide()


func show_panel() -> void:
	show()
	focus_panel.emit(self)
