extends Node2D

onready var player = get_node("Player")
onready var nav = get_node("Environment/Navigation2D")

func _on_Timer_timeout():
	get_tree().call_group("enemy", "get_target_path", player.global_position)

func _on_MissileClear_timeout():
	pass