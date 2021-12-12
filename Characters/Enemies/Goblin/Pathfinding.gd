extends Node

onready var player = Global.Player
onready var nav2d = get_tree().get_current_scene().get_node("Environment/Navigation2D")
onready var line_2d = get_node("Line2D")
onready var character = get_parent()

onready var path_refresh : float = 3.0

func _ready():
	print(character)
	print(player)

func _physics_process(delta):
	pass
#	if path_refresh <= 0:
#		print("path_refreshed")
#		var new_path = nav2d.get_simple_path(character.global_position, Global.Player.global_position)
#		line_2d.points = new_path
#		character.set_path(new_path)
#		path_refresh = 3.0
#	else:
#		path_refresh -= delta
#
	
