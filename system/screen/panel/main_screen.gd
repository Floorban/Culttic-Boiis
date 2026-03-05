class_name MainScreen extends Control

@onready var panel_container: Control = %PanelContainer
@onready var taskbar: HBoxContainer = %Taskbar
@onready var stats_panel: Panel = %StatsPanel

var sub_panels : Array[SubPanel]
var tab_btns: Array[Button]


func _ready() -> void:
	_init_sub_panels()


func _init_sub_panels() -> void:
	sub_panels.clear()
	for c in panel_container.get_children():
		if c is SubPanel:
			c.focus_panel.connect(_on_panel_opened)
			c.hide_panel()
			sub_panels.append(c)
	
	if sub_panels.is_empty():
		push_error("doesn't have any sub panels")
		return
	
	_init_tab_btns()


func _init_tab_btns() -> void:
	tab_btns.clear()
	for c in taskbar.get_children():
		if c is TabBtn:
			tab_btns.append(c)
	
	if tab_btns.is_empty():
		push_error("doesn't have any tab buttons")
		return
	
	_connect_tab_btns_to_sub_panels()


func _connect_tab_btns_to_sub_panels() -> void:
	for i in range(sub_panels.size()):
		tab_btns[i].pressed.connect(sub_panels[i].show_panel)
	
	#open first panel by default
	tab_btns[0].pressed.emit()


func _on_panel_opened(active_panel: SubPanel) -> void:
	for p in sub_panels:
		if p != active_panel:
			p.hide_panel()
