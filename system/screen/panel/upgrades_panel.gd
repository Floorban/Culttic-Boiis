extends SubPanel
class_name UpgradesManager

signal upgrade_changed(upgrade: UpgradeData, level: int)

@export var upgrade_btns: Array[UpgradeButton]
var upgrades: Array[UpgradeData]
var upgrade_levels: Dictionary[UpgradeData, int] = {}


func _ready() -> void:
	GameManager.upgrades_manager = self
	for upgrade_btn in upgrade_btns:
		upgrades.append(upgrade_btn.upgrade)
	for upgrade in upgrades:
		upgrade_levels[upgrade] = 0


func toggle_upgrade_panel(open: bool) -> void:
	visible = open
	if open:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func unlock(upgrade: UpgradeData) -> void:
	if not can_unlock(upgrade):
		return
	upgrade_levels[upgrade] += 1
	upgrade_changed.emit(upgrade, upgrade_levels[upgrade])


func get_level(upgrade: UpgradeData) -> int:
	return upgrade_levels.get(upgrade, 0)


func is_unlocked(upgrade: UpgradeData) -> bool:
	return get_level(upgrade) > 0


func can_unlock(upgrade: UpgradeData) -> bool:
	return get_level(upgrade) < upgrade.max_level
