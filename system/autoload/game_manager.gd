extends Node

var stats_manager: StatsManager
var upgrades_manager : UpgradesManager

var is_paused := false


func check_game_state(paused: bool) -> void:
	is_paused = paused
