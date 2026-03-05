class_name TabBtn extends TextureButton

@export var btn_display_name : String
@onready var displayed_text: Label = $DisplayedText

func _ready() -> void:
	displayed_text.text = btn_display_name
