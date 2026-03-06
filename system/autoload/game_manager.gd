extends Node

var is_paused := false

var stats_manager: StatsManager
var upgrades_manager : UpgradesManager


#func can_consume_points(amount: int) -> bool:
	#if current_score - amount < 0:
		#return false
	#return true
#
#
#func consume_points(amount: int) -> void:
	#current_score -= amount


func check_game_state(paused: bool) -> void:
	is_paused = paused
